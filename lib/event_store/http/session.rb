module EventStore
  module HTTP
    class Session
      include Log::Dependency

      configure :session

      dependency :connect, Connect

      attr_writer :connection

      setting :retry_limit
      setting :retry_duration

      def retry_duration
        @retry_duration ||= Defaults.retry_duration
      end

      def retry_limit
        @retry_limit ||= Defaults.retry_limit
      end

      def self.build(settings=nil, namespace: nil)
        settings ||= Settings.instance
        namespace ||= Array(namespace)

        instance = new
        Connect.configure instance, settings, namespace: namespace
        settings.set instance, namespace
        instance
      end

      def request(request)
        try { connection.request request }
      end

      def try(&block)
        retries ||= 0

        block.()

      rescue SystemCallError => error
        message = "Transmission error (ErrorClass: #{error.class}, Message: #{error})"

        unless retries < retry_limit
          logger.error { message }
          raise TransmissionError, message
        end

        logger.warn { message }
        establish_connection
        retries += 1

        retry 
      end

      def connection
        @connection ||= establish_connection
      end

      def establish_connection(ip_address=nil)
        self.connection = connect.(ip_address)
      end

      def retry_duration_seconds
        Rational(retry_duration, 1000)
      end

      TransmissionError = Class.new StandardError

      module Defaults
        def self.retry_duration
          value = ENV['EVENT_STORE_HTTP_RETRY_DURATION']

          return value.to_i if value

          value
        end

        def self.retry_limit
          value = ENV['EVENT_STORE_HTTP_RETRY_LIMIT']

          return value.to_i if value

          3
        end
      end
    end
  end
end
