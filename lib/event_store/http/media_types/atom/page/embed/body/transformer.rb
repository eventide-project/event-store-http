module EventStore
  module HTTP
    module MediaTypes
      module Atom
        class Page
          module Embed
            module Body
              module Transformer
                def self.json
                  JSON
                end

                def self.instance(raw_data)
                  page = Transform::Read.instance raw_data, Embed::Rich

                  raw_data[:entries].each_with_index do |entry_data, index|
                    event = page.entries.fetch index

                    data = JSON.read entry_data[:data]
                    event.content.data = data

                    unless entry_data[:meta_data].nil?
                      metadata = JSON.read entry_data[:meta_data]
                      event.content.metadata = metadata
                    end
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
