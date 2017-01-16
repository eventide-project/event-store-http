module EventStore
  module HTTP
    module Requests
      module Info
        class Get
          include Log::Dependency
          include Request

          configure :info_request

          def call
            logger.trace { "GET info endpoint" }

            request = Net::HTTP::Get.new uri_path

            http_response = connection.request request

            response = Transform::Read.(http_response.body, :json, Response)

            logger.debug { "GET info endpoint done (#{response.digest})" }

            response
          end

          def uri_path
            '/info'
          end
        end
      end
    end
  end
end
