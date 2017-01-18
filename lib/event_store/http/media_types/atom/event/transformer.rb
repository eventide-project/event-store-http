module EventStore
  module HTTP
    module MediaTypes
      module Atom
        class Event
          module Transformer
            def self.json
              JSON
            end

            def self.instance(raw_data)
              event = Event.new

              event.title = raw_data[:title]
              event.id = raw_data[:id]
              event.updated = raw_data[:updated]
              event.summary = raw_data[:summary]

              Links.set event.links, raw_data[:links]

              content = Content.new
              content.event_stream_id = raw_data[:content][:event_stream_id]
              content.event_number = raw_data[:content][:event_number]
              content.event_type = raw_data[:content][:event_type]
              content.data = raw_data[:content][:data]

              metadata = raw_data[:content][:metadata]
              content.metadata = metadata unless metadata.empty?

              event.content = content
              event
            end

            module JSON
              def self.read(text)
                EventStore::HTTP::JSON::Deserialize.(text)
              end
            end
          end
        end
      end
    end
  end
end
