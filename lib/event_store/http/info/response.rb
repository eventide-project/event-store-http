module EventStore
  module HTTP
    class Info
      class Response
        include Schema::DataStructure

        attribute :event_store_version, String
        attribute :state, String
        attribute :projections_mode, String

        def leader?
          state == Cluster::MemberState.leader
        end

        def follower?
          state == Cluster::MemberState.follower
        end

        def digest
          "EventStoreVersion: #{event_store_version}, State: #{Cluster::MemberState.digest state}, ProjectionsMode: #{projections_mode}"
        end
      end
    end
  end
end
