module EventStore
  module HTTP
    class ReadStream
      include Log::Dependency
      include Request

      configure :read_stream

      attr_accessor :long_poll_duration

      def call(stream, position: nil, batch_size: nil, direction: nil)
        batch_size ||= Defaults.batch_size
        position ||= Defaults.position
        direction ||= Defaults.direction

        logger.trace { "Reading stream (#{LogText.attributes stream, position, batch_size, direction})" }

        unless self.class.directions.include? direction
          error_message = "Invalid direction; not `forward' or `backward' (#{LogText.attributes stream, position, batch_size, direction})"
          logger.trace { error_message }
          raise ArgumentError, error_message
        end

        slice_path = self.slice_path stream, position, batch_size, direction

        request = Net::HTTP::Get.new slice_path
        request['Accept'] = MediaTypes::Atom.mime
        request['ES-LongPoll'] = long_poll_duration.to_s if long_poll_duration

        response = connection.request request

        case response
        when Net::HTTPSuccess
          logger.info { "Stream read (#{LogText.attributes stream, position, batch_size, direction, response: response})" }

          Transform::Read.(response.body, :json, MediaTypes::Atom::Page)

        when Net::HTTPNotFound
          error_message = "Stream not found (#{LogText.attributes stream, position, batch_size, direction, response: response})"
          logger.error error_message
          raise StreamNotFoundError, error_message

        else
          error_message = "Client error (#{LogText.attributes stream, position, batch_size, direction, response: response})"
          logger.error error_message
          raise Error, error_message
        end
      end

      def slice_path(stream, position, batch_size, direction)
        "/streams/#{stream}/#{position}/#{direction}/#{batch_size}"
      end

      def enable_long_poll
        self.long_poll_duration = Defaults.long_poll_duration
      end

      def self.directions
        [:forward, :backward]
      end

      Error = Class.new StandardError
      StreamNotFoundError = Class.new Error

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
