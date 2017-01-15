module EventStore
  module HTTP
    class Session
      module LogText
        def self.request(request, response=nil)
          text = %[Action: #{request.method}, Path: #{request.path}, RequestLength: #{request.body&.bytesize.to_i}]

          unless response.nil?
            text << %[, StatusCode: #{response.code}, ReasonPhrase: #{response.message}, ResponseLength: #{response.body&.bytesize.to_i}]
          end

          text
        end

        def self.header_data(message)
          text = String.new

          message.each_header do |name, value|
            text << "#{name}: #{value}\n"
          end

          if text.empty?
            text << "(none)"
          else
            text.insert 0, "\n\n"
          end

          text
        end

        def self.body_data(message)
          if message.body.to_s.empty?
            '(none)'
          else
            "\n\n#{message.body}\n"
          end
        end
      end
    end
  end
end
