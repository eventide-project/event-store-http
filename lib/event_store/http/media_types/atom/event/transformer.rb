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

              SetAttributes.(event, raw_data, exclude: [:content, :links])
              Links.set event.links, raw_data[:links]

              content = Content.new
              SetAttributes.(content, raw_data[:content], exclude: :metadata)

              metadata = raw_data[:content][:metadata]
              content.metadata = metadata unless metadata.empty?

              event.content = content
              event
            end

            module JSON
              def self.read(text)
                formatted_data = ::JSON.parse text, symbolize_names: true
                Casing::Underscore.(formatted_data)
              end
            end
          end
        end
      end
    end
  end
end
