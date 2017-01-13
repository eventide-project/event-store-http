module EventStore
  module HTTP
    module Controls
      module Hostname
        def self.example
          Available.example
        end

        module Other
          def self.example
            Available::Other.example
          end
        end

        module Available
          def self.example
            'eventstore.local'
          end

          module Other
            def self.example
              'alternate.eventstore.local'
            end
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
