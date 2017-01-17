module EventStore
  module HTTP
    class ReadStream
      module LogText
        def self.attributes(stream, position, batch_size, direction, response: nil)
          text = "Stream: #{stream}, Position: #{position}, BatchSize: #{batch_size}"

          unless response.nil?
            text << ", StatusCode: #{response.code}, ReasonPhrase: #{response.message}, ContentLength: #{response.body&.bytesize.to_i}"
          end

          text
        end
      end
    end
  end
end
