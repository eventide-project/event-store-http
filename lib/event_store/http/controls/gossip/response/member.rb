module EventStore
  module HTTP
    module Controls
      module Gossip
        module Response
          module Member
            def self.instance_id(member_index=nil)
              member_index ||= 1

              UUID.example member_index + 100
            end

            def self.time_stamp
              Controls::Time::Raw.example.iso8601 6
            end

            def self.state(member_index=nil)
              member_index ||= 1

              if member_index == 1
                State.leader
              else
                State.follower
              end
            end

            def self.is_alive(member_index=nil)
              if member_index == 3
                false
              else
                true
              end
            end

            def self.internal_tcp_ip(member_index=nil)
              IPAddress::Cluster.example member_index
            end
            singleton_class.send :alias_method, :external_tcp_ip, :internal_tcp_ip
            singleton_class.send :alias_method, :internal_http_ip, :internal_tcp_ip
            singleton_class.send :alias_method, :external_http_ip, :internal_tcp_ip

            def self.internal_tcp_port
              Port::TCP::Internal.example
            end

            def self.internal_secure_tcp_port
              0
            end

            def self.external_tcp_port
              Port::TCP::External.example
            end

            def self.external_secure_tcp_port
              0
            end

            def self.internal_http_port
              Port::Internal.example
            end

            def self.external_http_port
              Port.example
            end

            def self.last_commit_position
              1111
            end

            def self.writer_checkpoint
              111
            end

            def self.chaser_checkpoint
              11
            end

            def self.epoch_position
              222
            end

            def self.epoch_number
              22
            end

            def self.epoch_id
              UUID.example
            end

            def self.node_priority
              0
            end

            Leader = self

            module Index
              def self.leader
                1
              end

              def self.follower(follower_index=nil)
                follower_index ||= 1

                self.leader + follower_index
              end
            end
          end
        end
      end
    end
  end
end
