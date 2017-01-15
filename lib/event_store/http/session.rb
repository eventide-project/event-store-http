module EventStore
  module HTTP
    class Session
      include Log::Dependency

      configure :session

      dependency :connect, Connect
      dependency :retry, Retry

      attr_writer :net_http

      def self.build(settings=nil, namespace: nil)
        settings ||= Settings.instance
        namespace ||= Array(namespace)

        instance = new
        Connect.configure instance, settings, namespace: namespace
        Retry.configure instance, settings, namespace: namespace
        instance
      end

      def request(request)
        self.retry.() do |_retry|
          begin
            response = net_http.request request
          rescue SystemCallError => error
            net_http.finish

            logger.warn "Connection error during request; reconnecting (ErrorClass: #{error.class}, ErrorMessage: #{error.message})"
            reconnect

            _retry.next error
          end

          if Net::HTTPServerError === response
            logger.warn "Server responded with 5xx status code"
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
