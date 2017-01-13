module EventStore
  module HTTP
    module Controls
      module IPAddress
        def self.example
          Available.example
        end

        module Available
          def self.example
            '127.0.0.1'
          end
        end

        module Unavailable
          def self.example
            '127.0.0.2'
          end
        end
      end
    end
  end
end
