module EventStore
  module HTTP
    module Controls
      module Info
        module Response
          def self.event_store_version
            '1.1.1'
          end

          def self.state
            EventStore::HTTP::Cluster::MemberState.leader
          end

          def self.projections_mode
            'some-mode'
          end
        end
      end
    end
  end
end
