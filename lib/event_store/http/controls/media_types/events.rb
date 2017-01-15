module EventStore
  module HTTP
    module Controls
      module MediaTypes
        module Events
          def self.data(batch_size: nil, metadata: nil)
            batch_size ||= 1
            metadata = "some-metadata" if metadata == true

            data = EventStore::HTTP::MediaTypes::Events::Data.new

            (0...batch_size).each do |i|
              event_id = UUID.example i.next
              type = Event::Type.example
              event_data = Event::Data.example i

              _metadata = Event::Metadata.example i if metadata

              data.add_event event_id, type, event_data, _metadata
            end

            data
          end

          module JSON
            def self.text
              <<~JSON.chomp
              [
                {
                  "eventId": "#{UUID.example}",
                  "eventType": "#{Event::Type.example}",
                  "data": "#{Event::Data.example}"
                }
              ]
              JSON
            end
          end
        end
      end
    end
  end
end
