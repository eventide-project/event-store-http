module EventStore
  module HTTP
    module Controls
      module Info
        module Response
          module JSON
            def self.text(state: nil)
              state ||= :leader

              state = EventStore::HTTP::Cluster::MemberState.public_send state

              <<~JSON
              {
                "esVersion": "1.1.1",
                "state": "#{state}",
                "projectionsMode": "some-mode"
              }
              JSON
            end
          end
        end
      end
    end
  end
end
