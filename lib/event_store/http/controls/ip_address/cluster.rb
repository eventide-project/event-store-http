module EventStore
  module HTTP
    module Controls
      module IPAddress
        module Cluster
          def self.example(member_index=nil)
            Available.example member_index
          end

          def self.list
            Available.list
          end

          def self.get(third_octet, member_index: nil)
            member_index ||= 1

            "127.0.#{third_octet}.#{member_index}"
          end

          module Available
            def self.example(member_index=nil)
              Cluster.get '111', member_index: member_index
            end

            def self.list
              (1..Controls::Cluster::Size.example).map do |member_index|
                example member_index
              end
            end
          end

          module Unavailable
            def self.example(member_index=nil)
              Cluster.get '222', member_index: member_index
            end

            def self.list
              (1..Controls::Cluster::Size.example).map do |member_index|
                example member_index
              end
            end
          end

          module PartiallyAvailable
            def self.example(member_index=nil)
              if [nil, 1].include? member_index
                Unavailable.example member_index
              else
                Available.example member_index
              end
            end

            def self.list
              (1..Controls::Cluster::Size.example).map do |member_index|
                example member_index
              end
            end
          end
        end
      end
    end
  end
end
