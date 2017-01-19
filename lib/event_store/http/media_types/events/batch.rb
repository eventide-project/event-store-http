module EventStore
  module HTTP
    module MediaTypes
      module Events
        class Batch
          include Schema::DataStructure

          attribute :events, Array, default: ->{ Array.new }

          def size
            events.count
          end

          class Event
            include Schema::DataStructure

            attribute :id, String
            attribute :type, String
            attribute :data, Hash
            attribute :metadata, Hash
          end

          module Transformer
            def self.json
              JSON
            end

            def self.raw_data(instance)
              instance.events.map do |event|
                hash = {
                  :event_id => event.id,
                  :event_type => event.type,
                  :data => event.data
                }
                hash[:metadata] = event.metadata if event.metadata
                hash
              end
            end

            module JSON
              def self.write(raw_data)
                EventStore::HTTP::JSON::Serialize.(raw_data)
              end
            end
          end
        end
      end
    end
  end
end
