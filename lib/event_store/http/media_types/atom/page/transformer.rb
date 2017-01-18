module EventStore
  module HTTP
    module MediaTypes
      module Atom
        class Page
          module Transformer
            def self.json
              JSON
            end

            def self.instance(raw_data)
              page = Page.new

              SetAttributes.(page, raw_data, exclude: [:links, :entries])

              Links.set page.links, raw_data[:links]

              raw_data[:entries].each do |entry_data|
                event = Event.new

                SetAttributes.(event, entry_data, exclude: [:links, :is_meta_data, :is_link_meta_data])

                if [:event_number, :event_type, :stream_id].any? { |attribute| entry_data.key? attribute }
                  content = Event::Content.new
                  SetAttributes.(content, entry_data, copy: [:event_number, :event_type, { :stream_id => :event_stream_id }])
                  event.content = content
                end

                event.is_metadata = entry_data[:is_meta_data]
                event.is_link_metadata = entry_data[:is_link_meta_data]

                Links.set event.links, entry_data[:links]

                page.entries << event
              end

              page
            end

            module JSON
              def self.read(json_text)
                formatted_data = ::JSON.parse json_text, symbolize_names: true
                Casing::Underscore.(formatted_data)
              end
            end
          end
        end
      end
    end
  end
end
