module EventStore
  module HTTP
    module Controls
      module MediaTypes
        module Events
          def self.example(batch_size: nil, metadata: nil, random: nil)
            batch_size ||= 1
            metadata = "some-metadata" if metadata == true

            data = EventStore::HTTP::MediaTypes::Events::Data.new

            (0...batch_size).each do |i|
              if random
                event_id = Identifier::UUID::Random.get
              else
                event_id = UUID.example i.next
              end

              type = Event::Type.example
              event_data = Event::Data.example i

              metadata = Event::Metadata.example i if metadata

              event = EventStore::HTTP::MediaTypes::Events::Data::Event.new
              event.id = event_id
              event.type = type
              event.data = event_data
              event.metadata = metadata

              data.events << event
            end

            data
          end
        end
      end
    end
  end
end
