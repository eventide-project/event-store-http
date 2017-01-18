module EventStore
  module HTTP
    class Connect
      module Leader
        def self.build(settings=nil, namespace: nil)
          instance = Connect.build settings, namespace: namespace
          instance.extend self
          instance
        end

        def connect(net_http=nil)
          net_http ||= super()

          member_info = Info.(connection: net_http)

          return net_http if member_info.leader?

          cluster_status = Gossip.(connection: net_http)

          if cluster_status.leader.nil?
            error_message = "Leader is unavailable (Host: #{host}, Port: #{port})"
            logger.error { error_message }
            raise LeaderUnavailableError, error_message
          end

          leader_ip_address = cluster_status.leader.external_http_ip

          raw leader_ip_address
        end

        LeaderUnavailableError = Class.new StandardError
      end
    end
  end
end
