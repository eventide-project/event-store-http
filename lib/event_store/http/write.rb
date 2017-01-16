module EventStore
  module HTTP
    class Write
      include Log::Dependency
      include Request

      configure :write

      dependency :retry, Retry

      def configure(session: nil)
        if session.nil?
          Retry.configure self
        else
          session.configure_retry self
        end
      end

      def call(batch, stream, expected_version: nil)
        logger.trace { "Writing events (#{LogText.attributes batch, stream, expected_version})" }

        request = build_request batch, stream, expected_version: expected_version

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

      def build_request(batch, stream, expected_version: nil)
        path = self.class.stream_path stream

        request = Net::HTTP::Post.new path

        request['Content-Type'] = MediaTypes::Events.mime
        request['ES-ExpectedVersion'] = expected_version.to_s if expected_version

        request.body = Transform::Write.(batch, :json)

        request
      end

      def self.stream_path(stream)
        "/streams/#{stream}"
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
