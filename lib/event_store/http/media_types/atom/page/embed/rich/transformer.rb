module EventStore
  module HTTP
    module MediaTypes
      module Atom
        class Page
          module Embed
            module Rich
              module Transformer
                def self.json
                  JSON
                end

                def self.instance(raw_data)
                  page = Transform::Read.instance raw_data, Embed::None

                  raw_data[:entries].each_with_index do |entry_data, index|
                    event = page.entries.fetch index

                    event.extend Event

                    SetAttributes.(
                      event,
                      entry_data,
                      copy: [
                        :event_id,
                        :is_json,
                        :position_event_number,
                        :position_stream_id,
                        { :is_meta_data => :is_metadata },
                        { :is_link_meta_data => :is_link_metadata }
                      ]
                    )

                    content = Atom::Event::Content.new
                    SetAttributes.(
                      content,
                      entry_data,
                      copy: [
                        :event_number,
                        :event_type,
                        { :stream_id => :event_stream_id }
                      ]
                    )

                    event.content = content
                  end

                  page
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
  end
end
