module EventStore
  module HTTP
    class ReadEvent
      include Log::Dependency
      include Request

      configure :read_event

      attr_writer :output_schema

      def output_schema
        @output_schema ||= MediaTypes::Atom::Event
      end

      def call(uri=nil, stream: nil, position: nil)
        uri ||= self.event_path stream, position

        logger.trace { "Reading event (#{LogText.attributes uri})" }

        request = build_request uri

        response = connection.request request

        case response
        when Net::HTTPOK
          event = Transform::Read.(response.body, :json, output_schema)

          logger.info { "Read event done (#{LogText.attributes uri, response: response}, OutputSchema: #{output_schema})" }

          event

        when Net::HTTPNotFound
          error_message = "Event not found (#{LogText.attributes uri, response: response})"
          logger.error { error_message }
          raise EventNotFoundError, error_message

        else
          error_message = "Client error (#{LogText.attributes uri, response: response})"
          logger.error { error_message }
          raise Error, error_message
        end
      end

      def event_path(stream, position)
        if stream.nil? || position.nil?
          error_message = "Both stream and position must be specified when URI is omitted (Stream: #{stream.inspect}, Position: #{position.inspect})"
          logger.error { error_message }
          raise ArgumentError, error_message
        end

        "/streams/#{stream}/#{position}"
      end

      def build_request(uri)
        if uri.is_a? URI
          path = uri.path
        elsif uri.start_with? 'http'
          path = URI.parse(uri).path
        else
          path = uri
        end

        request = Net::HTTP::Get.new path
        request['Accept'] = MediaTypes::Atom.mime
        request
      end

      Error = Class.new StandardError
      EventNotFoundError = Class.new Error
    end
  end
end
