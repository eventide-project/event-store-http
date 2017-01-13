module EventStore
  module HTTP
    module Controls
      module Hostname
        def self.example
          Available.example
        end

        module Available
          def self.example
            'eventstore.local'
          end
        end

        module Unavailable
          def self.example
            'unavailable.eventstore.local'
          end
        end
      end
    end
  end
end
