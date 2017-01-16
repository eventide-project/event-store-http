module EventStore
  module HTTP
    module Controls
      module Write
        def self.call(events: nil, stream: nil)
          stream ||= Stream.example
          events ||= 1

          batch = MediaTypes::Events.example batch_size: events, random: true

          EventStore::HTTP::Write.(batch, stream)

          return stream, batch
        end
      end
    end
  end
end
