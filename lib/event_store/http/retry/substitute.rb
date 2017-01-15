module EventStore
  module HTTP
    class Retry
      module Substitute
        def self.build
          Retry.build
        end

        class Retry < Retry
          attr_accessor :error
          attr_accessor :telemetry_sink

          def self.build
            instance = new

            ::Telemetry.configure instance
            instance.telemetry_sink = Retry.register_telemetry_sink instance

            instance.retry_duration = 0
            instance.retry_limit = 1
            instance
          end

          def call(&block)
            super do |_, retries|
              return_value = block.(self, retries)

              raise error if error

              return_value
            end
          end

          def set_error(error)
            self.error = error
          end
        end
      end
    end
  end
end
