module EventStore
  module HTTP
    module Controls
      module Hostname
        module Cluster
          def self.example
            Available.example
          end

          module Leader
            def self.example
              'leader.eventstore-cluster.local'
            end
          end

          module Followers
            def self.example
              'followers.eventstore-cluster.local'
            end
          end

          module Available
            def self.example
              'eventstore-cluster.local'
            end

            module Member
              def self.example(member_index=nil)
                member_index ||= 1

                "eventstore-cluster-#{member_index}.local"
              end
            end
          end

          module Unavailable
            def self.example
              'unavailable.eventstore-cluster.local'
            end

            module Member
              def self.example(member_index=nil)
                member_index ||= 1

                "unavailable.eventstore-cluster-#{member_index}.local"
              end
            end
          end

          module PartiallyAvailable
            def self.example
              'partially-available.eventstore-cluster.local'
            end

            module Member
              def self.example(member_index=nil)
                member_index ||= 1

                "partially-available.eventstore-cluster-#{member_index}.local"
              end
            end
          end
        end
      end
    end
  end
end
