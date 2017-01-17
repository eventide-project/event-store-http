module EventStore
  module HTTP
    class ReadEvent
      module LogText
        def self.attributes(uri, response: nil)
          text = "URI: #{uri}"

          unless response.nil?
            text << ", StatusCode: #{response.code}, ReasonPhrase: #{response.message}, ContentLength: #{response&.body.bytesize.to_i}"
          end

          text
        end
      end
    end
  end
end
