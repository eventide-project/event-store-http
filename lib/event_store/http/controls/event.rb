module EventStore
  module HTTP
    module Controls
      module Event
        module ID
          def self.example(i=nil)
            UUID.example i
          end
        end

        module Type
          def self.example
            'SomeType'
          end
        end

        module Data
          def self.example(i=nil)
            i ||= 0

            "some-event-#{i}"
          end
        end

        module Metadata
          def self.example(i=nil)
            i ||= 0

            "some-metadata-#{i}"
          end
        end
      end
    end
  end
end
