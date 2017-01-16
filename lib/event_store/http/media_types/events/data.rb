module EventStore
  module HTTP
    module MediaTypes
      module Events
        class Data
          include Schema::DataStructure

          attribute :events, Array, default: ->{ Array.new }

          def add_event(id, type, data, metadata=nil)
            event = Event.build(
              :id => id,
              :type => type,
              :data => data,
              :metadata => metadata
            )

            events << event

            event
          end

          class Event
            include Schema::DataStructure

            attribute :id, String
            attribute :type, String
            attribute :data, String
            attribute :metadata, String
          end

          module Transformer
            def self.json
              Serialization::JSON
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
          end
        end
      end
    end
  end
end
