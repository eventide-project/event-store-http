module EventStore
  module HTTP
    class ReadEvent
      module Substitute
        def self.build
          ReadEvent.new
        end

        class ReadEvent < ReadEvent
          attr_accessor :response

          def call(uri=nil, stream: nil, position: nil)
            uri ||= event_path stream, position

            uri = URI(uri)

            events.fetch uri.path do
              raise EventNotFoundError
            end
          end

          def set_response(event, stream, position)
            path = event_path stream, position

            events[path] = event
          end

          def events
            @events ||= {}
          end
        end
      end
    end
  end
end
