module EventStore
  module HTTP
    class Retry
      include Log::Dependency

      configure :retry

      dependency :telemetry, ::Telemetry

      setting :retry_limit
      setting :retry_duration

      def retry_limit
        @retry_limit ||= Defaults.retry_limit
      end

      def retry_duration
        @retry_duration ||= Defaults.retry_duration
      end

      def self.build(settings=nil, namespace: nil)
        settings ||= Settings.instance
        namespace ||= Array(namespace)

        instance = new
        ::Telemetry.configure instance
        settings.set instance, namespace
        instance
      end

      def self.register_telemetry_sink(instance)
        sink = Telemetry::Sink.new
        instance.telemetry.register sink
        sink
      end

      def call(&block)
        retries ||= 0

        logger.trace { "Performing operation (Retries: #{retries}/#{retry_limit})" }

        return_value = block.(self, retries)

        logger.debug { "Operation succeeded (Retries: #{retries}/#{retry_limit})" }

        return_value

      rescue => error
        if retries == retry_limit
          logger.error { "Operation failed; retry limit exceeded (Retries: #{retries}/#{retry_limit}, ErrorClass: #{error.class}, ErrorMessage: #{error.message.empty? ? '(none)' : error.message})" }
          raise error
        end

        logger.warn { "Operation failed; retrying (Retries: #{retries}/#{retry_limit}, ErrorClass: #{error.class}, ErrorMessage: #{error.message.empty? ? '(none)' : error.message})" }

        retries += 1
        sleep retry_duration_seconds
        record_retry error, retries

        retry
      end

      def next
        raise Trigger
      end

      def record_retry(error, retries)
        telemetry.record :retried, Telemetry::Retried.new(error, retries, retry_limit)
      end

      def retry_duration_seconds
        Rational(retry_duration, 1_000)
      end

      Trigger = Class.new StandardError

      module Defaults
        def self.retry_duration
          value = ENV['EVENT_STORE_HTTP_RETRY_DURATION']

          return value.to_i if value

          300
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
