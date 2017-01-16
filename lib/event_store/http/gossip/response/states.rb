module EventStore
  module HTTP
    class Gossip
      class Response
        module States
          def self.leader
            'Master'
          end

          def self.follower
            'Slave'
          end
        end
      end
    end
  end
end
