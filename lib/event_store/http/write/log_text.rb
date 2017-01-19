module EventStore
  module HTTP
    class Write
      module LogText
        def self.attributes(batch, stream, expected_version=nil, response: nil)
          text = "BatchSize: #{batch.size}, Stream: #{stream}, ExpectedVersion: #{expected_version || '(none)'}"

          unless response.nil?
            text << ", StatusCode: #{response.code}, ReasonPhrase: #{response.message}"
          end

          text
        end
      end
    end
  end
end
