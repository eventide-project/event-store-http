module EventStore
  module HTTP
    module Endpoints
      module Gossip
        class Response
          class Member
            include Schema::DataStructure

            attribute :instance_id, String
            attribute :time_stamp, String
            attribute :state, String
            attribute :is_alive

            attribute :internal_tcp_ip, String
            attribute :internal_tcp_port, Integer
            attribute :internal_secure_tcp_port, Integer

            attribute :external_tcp_ip, String
            attribute :external_tcp_port, Integer
            attribute :external_secure_tcp_port, Integer

            attribute :internal_http_ip, String
            attribute :internal_http_port, Integer

            attribute :external_http_ip, String
            attribute :external_http_port, Integer

            attribute :last_commit_position, Integer
            attribute :writer_checkpoint, Integer
            attribute :chaser_checkpoint, Integer

            attribute :epoch_position, Integer
            attribute :epoch_number, Integer
            attribute :epoch_id, String

            attribute :node_priority, Integer
          end
        end
      end
    end
  end
end
