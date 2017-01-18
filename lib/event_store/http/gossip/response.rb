module EventStore
  module HTTP
    class Gossip
      class Response
        include Schema::DataStructure

        attribute :server_ip, String
        attribute :server_port, Integer
        attribute :leader, Member
        attribute :followers, Array, default: ->{ Array.new }
        attribute :unknown, Array, default: ->{ Array.new }

        def add_member(member)
          if member.state == Cluster::MemberState.leader
            self.leader = member
          elsif member.state == Cluster::MemberState.follower
            followers << member
          else
            unknown << member
          end
        end
      end
    end
  end
end
