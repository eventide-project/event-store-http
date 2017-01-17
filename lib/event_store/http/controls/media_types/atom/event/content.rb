module EventStore
  module HTTP
    module Controls
      module MediaTypes
        module Atom
          module Event
            module Content
              def self.example(position=nil, metadata: nil)
                position ||= 0

                metadata = metadata position if metadata == true

                content = EventStore::HTTP::MediaTypes::Atom::Event::Content.new
                content.event_stream_id = event_stream_id
                content.event_number = event_number position
                content.event_type = event_type
                content.data = data position
                content.metadata = metadata unless metadata.nil?
                content
              end

              def self.event_stream_id
                Page.stream
              end

              def self.event_number(position=nil)
                position || 0
              end

              def self.event_type
                Controls::Event::Type.example
              end

              def self.data(position=nil)
                Controls::Event::Data.example position
              end

              def self.metadata(position=nil)
                Controls::Event::Metadata.example position
              end
            end
          end
        end
      end
    end
  end
end
