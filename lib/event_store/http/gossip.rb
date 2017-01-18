module EventStore
  module HTTP
    class Gossip
      include Log::Dependency
      include Request

      configure :gossip

      def call
        logger.trace { "GET gossip endpoint" }

        request = Net::HTTP::Get.new uri_path

        http_response = connection.request request

        response = Transform::Read.(http_response.body, :json, Response)

        logger.debug { "GET gossip endpoint done (LeaderIPAddress: #{response.leader&.external_http_ip.inspect}, FollowerCount: #{response.followers.count})" }

        return response
      end

      def uri_path
        '/gossip'
      end
    end
  end
end
