module EventStore
  module HTTP
    class Session
      include Log::Dependency

      configure :session

      dependency :connect, Connect
      dependency :data_logger, Log::Data
      dependency :retry, Retry

      attr_writer :net_http

      def self.build(settings=nil, namespace: nil)
        settings ||= Settings.instance
        namespace ||= Array(namespace)

        instance = new
        Connect.configure instance, settings, namespace: namespace
        Retry.configure instance, settings, namespace: namespace
        Log::Data.configure instance, self, attr_name: :data_logger
        instance
      end

      def request(request)
        logger.trace { "Issuing request (#{LogText.request request})" }
        data_logger.trace { "Headers: #{LogText.header_data request}" }
        data_logger.trace { "Request data: #{LogText.body_data request}" }

        self.retry.() do |_retry|
          begin
            response = net_http.request request
          rescue SystemCallError => error
            net_http.finish

            logger.warn "Connection error during request; reconnecting (ErrorClass: #{error.class}, ErrorMessage: #{error.message})"
            reconnect

            _retry.next error
          end

          logger.debug { "Received response (#{LogText.request request, response})" }
          data_logger.trace { "Headers: #{LogText.header_data response}" }
          data_logger.trace { "Response data: #{LogText.body_data response}" }

          if Net::HTTPServerError === response
            logger.warn { "Server error (#{LogText.request request, response})" }
            _retry.next
          end

          response
        end
      end

      def net_http
        @net_http ||= establish_connection
      end

      def reconnect
        net_http.finish
        establish_connection
      end

      def establish_connection(ip_address=nil)
        logger.trace { "Establishing connection (IPAddress: #{ip_address || '(none)'})" }

        net_http = self.retry.() do
          connect.(ip_address).tap &:start
        end

        self.net_http = net_http

        logger.debug { "Connection established (IPAddress: #{ip_address || '(none)'}, Host: #{net_http.address}, Port: #{net_http.port})" }

        net_http
      end
    end
  end
end
