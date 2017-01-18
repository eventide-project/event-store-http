module EventStore
  module HTTP
    module Controls
      module URI
        module Event
          def self.example(stream: nil, position: nil)
            stream ||= Stream.example
            position ||= 0

            ip_address = IPAddress.example
            port = Port.example

            ::URI.parse "http://#{ip_address}:#{port}/streams/#{stream}/#{position}"
          end

          def self.raw(stream: nil, position: nil)
            uri = example stream: stream, position: position
            uri.to_s
          end
        end
      end
    end
  end
end
