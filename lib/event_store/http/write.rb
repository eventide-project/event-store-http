module EventStore
  module HTTP
    class Write
      include Log::Dependency

      configure :write

      dependency :connection, Net::HTTP
      dependency :retry, Retry

      def self.build(connection=nil)
        instance = new
        Connect.configure_connection instance, connection: connection
        Retry.configure instance
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

        response = nil
        
        self.retry.() do |_retry|
          response = connection.request request

          if write_timeout? response
            logger.warn { "Write timeout (#{LogText.attributes batch, stream, expected_version, response: response})" }
            _retry.failed
          end
        end

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
          error_message = "Request failed (#{LogText.attributes batch, stream, expected_version, response: response})"
          logger.error { error_message }
          raise Error, error_message
        end
      end

      def wrong_expected_version?(response)
        Net::HTTPBadRequest === response && response.message == "Wrong expected EventNumber"
      end

      def write_timeout?(response)
        Net::HTTPBadRequest === response && response.message == "Write timeout"
      end

      Error = Class.new StandardError
      ExpectedVersionError = Class.new Error
    end
  end
end
