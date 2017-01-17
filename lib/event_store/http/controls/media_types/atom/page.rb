module EventStore
  module HTTP
    module Controls
      module MediaTypes
        module Atom
          module Page
            def self.example(embed_rich: nil, backward: nil)
              page = EventStore::HTTP::MediaTypes::Atom::Page.new
              page.id = id
              page.updated = updated
              page.stream_id = stream_id
              page.links = Links.example backward: backward

              Entries.count.times do |index|
                entry = Entries.example index, embed_rich: embed_rich

                page.entries << entry
              end

              page
            end

            def self.stream
              Stream.example random: false
            end

            def self.id
              "http://#{Controls::IPAddress.example}:#{Port.example}/streams/#{stream}"
            end

            def self.updated
              Controls::Time::Raw.example.iso8601 6
            end

            def self.stream_id
              stream
            end
          end
        end
      end
    end
  end
end
