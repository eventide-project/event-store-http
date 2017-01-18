module EventStore
  module HTTP
    module MediaTypes
      module Atom
        class Page
          module Embed
            module None
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

                    Links.set event.links, entry_data[:links]

                    page.entries << event
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
