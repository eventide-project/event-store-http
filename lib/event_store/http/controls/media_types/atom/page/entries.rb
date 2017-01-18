module EventStore
  module HTTP
    module Controls
      module MediaTypes
        module Atom
          module Page
            module Entries
              def self.example(index=nil, embed: nil)
                position = self.position index

                entry = Event.example position, content: false

                if embed
                  entry.extend EventStore::HTTP::MediaTypes::Atom::Page::Embed::Rich::Event

                  content = EventStore::HTTP::MediaTypes::Atom::Event::Content.new

                  content.event_stream_id = stream_id
                  content.event_number = event_number index
                  content.event_type = event_type

                  entry.content = content

                  entry.event_id = event_id index
                  entry.is_json = is_json
                  entry.is_metadata = is_metadata
                  entry.is_link_metadata = is_link_metadata
                  entry.position_event_number = position_event_number index
                  entry.position_stream_id = position_stream_id
                end

                if embed == :body
                  entry.content.data = Controls::Event::Data.example position
                  entry.content.metadata = Controls::Event::Metadata.example position
                end

                entry
              end

              def self.count
                3
              end

              def self.position(index=nil)
                index ||= 0

                count - index - 1
              end

              def self.event_id(index=nil)
                position = self.position index

                UUID.example position
              end

              def self.event_type
                Event::Content.event_type
              end

              def self.event_number(index=nil)
                position index
              end

              def self.stream_id
                Page.stream_id
              end

              def self.is_json
                true
              end

              def self.is_metadata
                false
              end

              def self.is_link_metadata
                false
              end

              def self.position_event_number(index=nil)
                position = self.position index

                position * 111
              end

              def self.position_stream_id
                "readStream"
              end

              def self.title(index=nil)
                position = self.position index

                Event.title position
              end

              def self.id(index=nil)
                position = self.position index

                Event.id position
              end

              def self.summary
                Event.summary
              end

              module Links
                def self.example(index=nil)
                  position = Entries.position index

                  Event::Links.example position
                end

                def self.edit(index=nil)
                  position = Entries.position index

                  Event::Links.edit position
                end

                def self.alternate(index=nil)
                  position = Entries.position index

                  Event::Links.alternate position
                end
              end
            end
          end
        end
      end
    end
  end
end
