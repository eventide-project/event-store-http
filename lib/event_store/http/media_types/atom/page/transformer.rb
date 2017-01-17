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
                entry = Page::Entry.new

                SetAttributes.(entry, entry_data, exclude: :links)

                Links.set entry.links, entry_data[:links]

                page.entries << entry
              end

              page
            end

            module Links
              def self.set(target, links)
                links.each do |hash|
                  uri = hash.fetch :uri
                  relation = hash.fetch :relation

                  relation = Casing::Underscore.(relation)

                  target[relation.to_sym] = uri
                end
              end
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
