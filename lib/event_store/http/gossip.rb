module EventStore
  module HTTP
    class Gossip
      include Log::Dependency
      include Request

      configure :gossip

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
