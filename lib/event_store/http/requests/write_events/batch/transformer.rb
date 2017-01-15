module EventStore
  module HTTP
    module Requests
      module WriteEvents
        class Batch
          module Transformer
            def self.json
              JSON
            end

            def self.raw_data(batch)
              batch.events.map do |event|
                data = {
                  :event_id => event.id,
                  :event_type => event.type,
                  :data => event.data
                }
                data[:metadata] = event.metadata if event.metadata
                data
              end
            end

            module JSON
              def self.write(raw_data)
                formatted_data = Casing::Camel.(raw_data, symbol_to_string: true)
                ::JSON.pretty_generate formatted_data
              end
            end
          end
        end
      end
    end
  end
end
