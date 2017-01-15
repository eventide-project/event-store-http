module EventStore
  module HTTP
    class Retry
      module Telemetry
        class Sink
          include ::Telemetry::Sink

          record :retried
        end

        Retried = Struct.new :error, :retries, :retry_limit
      end
    end
  end
end
