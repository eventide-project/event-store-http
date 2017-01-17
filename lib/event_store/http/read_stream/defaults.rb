module EventStore
  module HTTP
    class ReadStream
      module Defaults
        def self.batch_size
          batch_size = ENV['EVENT_STORE_HTTP_READ_BATCH_SIZE']

          return batch_size.to_i if batch_size

          20
        end

        def self.direction
          :forward
        end

        def self.long_poll_duration
          long_poll_duration = ENV['EVENT_STORE_HTTP_LONG_POLL_DURATION']

          return long_poll_duration.to_i if long_poll_duration

          2
        end

        def self.position
          0
        end
      end
    end
  end
end
