module EventStore
  module HTTP
    class Connect
      module Leader
        def self.build(settings=nil, namespace: nil)
          instance = Connect.build settings, namespace: namespace
          instance.extend self
          instance
        end

        def connect
          net_http = super

          member_info = Requests::Info::Get.(net_http)

          return net_http if member_info.leader?

          cluster_status = Requests::Gossip::Get.(net_http)

          leader_ip_address = cluster_status.leader.external_http_ip

          raw leader_ip_address
        end
      end
    end
  end
end
