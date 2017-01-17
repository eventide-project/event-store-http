module EventStore
  module HTTP
    module Controls
      module MediaTypes
        module Atom
          module Event
            def self.example(position=nil)
              event = EventStore::HTTP::MediaTypes::Atom::Event.new
              event.title = title position
              event.id = id position
              event.updated = updated
              event.summary = summary
              event.content = Content.example position
              event.links = Links.example position
              event
            end

            def self.title(position=nil)
              position ||= 0

              "#{position}@testStream"
            end

            def self.id(position=nil)
              position ||= 0

              "http://#{Controls::IPAddress.example}:#{Port.example}/streams/#{Page.stream}/#{position}"
            end

            def self.summary
              Content.event_type
            end
          end
        end
      end
    end
  end
end
