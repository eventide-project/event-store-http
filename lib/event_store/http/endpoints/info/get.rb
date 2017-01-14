module EventStore
  module HTTP
    module Endpoints
      module Info
        class Get
          include Log::Dependency

          configure :get_info_endpoint

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
            logger.trace { "GET info endpoint" }

            request = Net::HTTP::Get.new uri_path

            response = connection.request request

            response = Transform::Read.(response.body, :json, Response)

            logger.debug { "GET info done (#{response.digest})" }

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
