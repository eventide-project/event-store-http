module EventStore
  module HTTP
    module Requests
      module WriteEvents
        class Post
          include Log::Dependency

          configure :post_events

          dependency :session, Session

          def self.build(session: nil)
            instance = new
            Session.configure instance, session: session
            instance
          end

          def self.call(batch, stream_name, session: session, **arguments)
            instance = build session: session
            instance.(batch, stream_name, **arguments)
          end

          def call(batch, stream_name, expected_version: nil)
            request = Net::HTTP::Post.new "/streams/#{stream_name}"
            request.body = Transform::Write.(batch, :json)
            request['content-type'] = 'application/vnd.eventstore.events+json'

            response = session.request request

          end
        end
      end
    end
  end
end
