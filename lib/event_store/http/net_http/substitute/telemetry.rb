module EventStore
  module HTTP
    module NetHTTP
      class Substitute
        module Telemetry
          class Sink
            include ::Telemetry::Sink

            record :requested
            record :responded
          end

          Requested = Struct.new :request
          Responded = Struct.new :response, :request
        end
      end
    end
  end
end
