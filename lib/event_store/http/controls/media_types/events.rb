module EventStore
  module HTTP
    module Controls
      module MediaTypes
        module Events
          def self.example(batch_size: nil, metadata: nil, random: nil)
            batch_size ||= 1
            metadata = "some-metadata" if metadata == true

            batch = EventStore::HTTP::MediaTypes::Events::Batch.new

            (0...batch_size).each do |i|
              if random
                event_id = Identifier::UUID::Random.get
              else
                event_id = UUID.example i.next
              end

              type = Event::Type.example
              event_data = Event::Data.example i

              metadata = Event::Metadata.example i if metadata

              event = EventStore::HTTP::MediaTypes::Events::Batch::Event.new
              event.id = event_id
              event.type = type
              event.data = event_data
              event.metadata = metadata

              batch.events << event
            end

            batch
          end
        end
      end
    end
  end
end
