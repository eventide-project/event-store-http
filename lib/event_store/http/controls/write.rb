module EventStore
  module HTTP
    module Controls
      module Write
        def self.call(events: nil, stream: nil, session: nil, metadata: nil)
          stream ||= Stream.example
          events ||= 1

          batch = MediaTypes::Events.example(
            batch_size: events,
            metadata: metadata,
            random: true
          )

          EventStore::HTTP::Write.(batch, stream, session: session)

          return stream, batch
        end
      end
    end
  end
end
