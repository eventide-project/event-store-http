module EventStore
  module HTTP
    class Session
      include Log::Dependency

      configure :session

      dependency :connect, Connect
      dependency :retry, Retry

      attr_writer :connection

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
            response = connection.request request
          rescue SystemCallError => error
            connection.finish

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

      def connection
        @connection ||= establish_connection
      end

      def establish_connection(ip_address=nil)
        self.connection = self.retry.() do
          connect.(ip_address).tap &:start
        end
      end
      alias_method :reconnect, :establish_connection

      def retry_duration_seconds
        Rational(retry_duration, 1000)
      end
    end
  end
end
