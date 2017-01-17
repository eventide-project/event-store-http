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
              class ObjectClass < Hash
                def []=(raw_key, value)
                  key = key_cache[raw_key]

                  super key, value
                end

                def key_cache
                  @@key_cache ||= Hash.new do |cache, raw_key|
                    cache[raw_key] = Casing::Underscore.(raw_key).to_sym
                  end
                end
              end

              def self.read(text)
                ::JSON.parse text, object_class: ObjectClass
              end
            end
          end
        end
      end
    end
  end
end
