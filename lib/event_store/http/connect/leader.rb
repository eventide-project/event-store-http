module EventStore
  module HTTP
    module Connect
      class Leader
        include Connect

        def call
          net_http = raw host

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
