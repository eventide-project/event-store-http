module EventStore
  module HTTP
    module Controls
      module Hostname
        module Cluster
          def self.example
            Available.example
          end

          module Available
            def self.example
              'eventstore-cluster.local'
            end
          end

          module PartiallyAvailable
            def self.example
              'partially-available.eventstore-cluster.local'
            end
          end

          module Unavailable
            def self.example
              'unavailable.eventstore-cluster.local'
            end
          end
        end
      end
    end
  end
end
