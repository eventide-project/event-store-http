module EventStore
  module HTTP
    module Controls
      module Gossip
        module Response
          def self.server_ip
            IPAddress::Cluster.example
          end

          def self.server_port
            Port::Internal.example
          end
        end
      end
    end
  end
end
