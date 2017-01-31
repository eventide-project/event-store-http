module EventStore
  module HTTP
    module Session
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

          if message['host']
            text << "host: #{message['host']}\n"
          end

          message.each_header do |name, value|
            next if name == 'host'

            text << "#{name}: #{value}\n"
          end

          text << "(no headers)" if text.empty?

          text
        end

        def self.body_data(message)
          if message.body.to_s.empty?
            '(no body)'
          else
            message.body
          end
        end
      end
    end
  end
end
