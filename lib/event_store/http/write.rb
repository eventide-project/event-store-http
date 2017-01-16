module EventStore
  module HTTP
    class Write
      include Log::Dependency

      configure :write

      dependency :connection, Net::HTTP

      def self.build(connection=nil)
        instance = new
        Connect.configure_connection instance, connection: connection
        instance
      end

      def self.call(events, stream, expected_version: nil, connection: nil)
        instance = build connection
        instance.(events, stream, expected_version: expected_version)
      end

      def call(batch, stream, expected_version: nil)
        logger.trace { "Writing events (#{LogText.attributes batch, stream, expected_version})" }

        request = Net::HTTP::Post.new "/streams/#{stream}"
        request['content-type'] = MediaTypes::Events.mime
        request['es-expectedversion'] = expected_version.to_s if expected_version
        request.body = Transform::Write.(batch, :json)

        response = connection.request request

        case response
        when Net::HTTPCreated then
          location = response['location']
          logger.info { "Events written (#{LogText.attributes batch, stream, expected_version, response: response}, Location: #{location})" }
          URI.parse location

        when proc { wrong_expected_version? response }
          error_message = "Wrong expected version (#{LogText.attributes batch, stream, expected_version, response: response})"
          logger.error { error_message }
          raise ExpectedVersionError, error_message

        else
          fail
        end
      end

      def wrong_expected_version?(response)
        Net::HTTPBadRequest === response && response.message == "Wrong expected EventNumber"
      end

      ExpectedVersionError = Class.new StandardError
    end
  end
end
