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

            "http://#{ip_address}:#{port}/streams/#{stream}/#{position}"
          end
        end
      end
    end
  end
end
