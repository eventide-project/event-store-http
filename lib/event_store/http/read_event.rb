module EventStore
  module HTTP
    class ReadEvent
      include Log::Dependency
      include Request

      configure :read_event

      def call(uri=nil, stream: nil, position: nil)
        uri ||= self.event_path stream, position

        request = Net::HTTP::Get.new uri
        request['Accept'] = MediaTypes::Atom.mime

        response = connection.request request

        case response
        when Net::HTTPOK
          Transform::Read.(response.body, :json, MediaTypes::Atom::Event)

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

      Error = Class.new StandardError
      EventNotFoundError = Class.new Error
    end
  end
end
