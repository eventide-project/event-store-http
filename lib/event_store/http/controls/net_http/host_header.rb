module EventStore
  module HTTP
    module Controls
      module NetHTTP
        module HostHeader
          def self.example(address=nil)
            return IPAddress.example if address.nil?

            port = Port.example

            "#{address}:#{port}"
          end

          module Other
            def self.example
              address = Controls::Hostname.example

              HostHeader.example address
            end
          end

          module Hostname
            def self.example
              address = Controls::Hostname.example

              HostHeader.example address
            end
          end

          module IPAddress
            def self.example
              address = Controls::IPAddress.example

              HostHeader.example address
            end
          end
        end
      end
    end
  end
end
