module EventStore
  module HTTP
    module Session
      def self.included(cls)
        cls.class_exec do
          include Log::Dependency

          dependency :connect, Connect
          dependency :data_logger, Log::Data
          dependency :retry, Retry

          attr_writer :net_http
        end
      end

      def self.build(settings=nil, namespace: nil, type: nil)
        Factory.(settings, namespace: namespace, type: type)
      end

      def self.configure(receiver, settings=nil, attr_name: nil, session: nil, **arguments)
        attr_name ||= :session

        if session.nil?
          session = build settings, **arguments
        end

        receiver.public_send "#{attr_name}=", session
        session
      end

      Virtual::Method.define self, :configure

      def request(request)
        logger.trace { "Issuing request (#{LogText.request request})" }
        data_logger.trace { "Request headers: #{LogText.header_data request}" }
        data_logger.trace { "Request data: #{LogText.body_data request}" }

        self.retry.() do |_retry|
          begin
            response = net_http.request request
          rescue SystemCallError, IOError => error
            logger.warn "Connection error during request; reconnecting (ErrorClass: #{error.class}, ErrorMessage: #{error.message})"
            reconnect

            reset_request request

            _retry.failed error
          end

          logger.debug { "Received response (#{LogText.request request, response})" }

          data_logger.debug { "Request location: #{request.path}" }
          data_logger.debug { "Request headers: #{LogText.header_data request}" }
          data_logger.debug { "Request data: #{LogText.body_data request}" }
          data_logger.debug { "Response headers: #{LogText.header_data response}" }
          data_logger.debug { "Response data: #{LogText.body_data response}" }

          if Net::HTTPServerError === response
            logger.warn { "Server error (#{LogText.request request, response})" }
            _retry.failed
          end

          response
        end
      end

      def net_http
        @net_http ||= establish_connection
      end

      def reconnect(ip_address=nil)
        net_http.finish if net_http.active?

        establish_connection ip_address
      end

      def establish_connection(ip_address=nil)
        data_logger.trace { "Establishing connection (IPAddress: #{ip_address || '(none)'})" }

        net_http = self.retry.() do
          connect.(ip_address).tap &:start
        end

        self.net_http = net_http

        data_logger.debug { "Connection established (IPAddress: #{net_http.ip_address}, Host: #{net_http.address}, Port: #{net_http.port})" }

        net_http
      end

      def configure_retry(request)
        request.retry = self.retry
      end

      def reset_request(request)
        request['host'] = nil
        request['connection'] = nil
      end
    end
  end
end
