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

            { :some_attribute => "some-value-#{i}" }
          end

          def self.text(i=nil)
            ::JSON.generate example(i)
          end
        end

        module Metadata
          def self.example(i=nil)
            i ||= 0

            { :some_meta_attribute => "some-meta-value-#{i}" }
          end

          def self.text(i=nil)
            ::JSON.generate example(i)
          end
        end
      end
    end
  end
end
