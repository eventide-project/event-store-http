module EventStore
  module HTTP
    module Endpoints
      module Info
        class Response
          include Schema::DataStructure

          attribute :event_store_version, String
          attribute :state, String
          attribute :projections_mode, String

          def leader?
            state == States.leader
          end

          def follower?
            state == States.follower
          end

          def digest
            "EventStoreVersion: #{event_store_version}, State: #{States.digest state}, ProjectionsMode: #{projections_mode}"
          end
        end
      end
    end
  end
end
