module EventStore
  module HTTP
    module Requests
      module Gossip
        class Get
          include Log::Dependency

          configure :gossip_request

          dependency :connection, Net::HTTP

          def self.build(connection=nil)
            instance = new
            Connect.configure_connection instance, connection: connection
            instance
          end

          def self.call(connection=nil)
            instance = build connection
            instance.()
          end

          def call
            logger.trace { "GET gossip endpoint" }

            http_response = connection.get uri_path

            response = Transform::Read.(http_response.body, :json, Response)

            logger.debug { "GET gossip endpoint done (LeaderIPAddress: #{response.leader.external_http_ip}, FollowerCount: #{response.followers.count})" }

            return response
          end

          def uri_path
            '/gossip'
          end
        end
      end
    end
  end
end
