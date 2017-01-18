module EventStore
  module HTTP
    module Cluster
      module MemberState
        def self.leader
          'Master'
        end

        def self.follower
          'Slave'
        end

        def self.unknown
          'Unknown'
        end

        def self.digest(state)
          case state
          when leader then 'Leader'
          when follower then 'Follower'
          when unknown then 'Unknown'
          else state
          end
        end
      end
    end
  end
end
