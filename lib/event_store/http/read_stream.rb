module EventStore
  module HTTP
    class ReadStream
      include Log::Dependency
      include Request

      configure :read_stream

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
          fail
        end
      end

      def slice_path(stream, position, batch_size, direction)
        "/streams/#{stream}/#{position}/#{direction}/#{batch_size}"
      end

      def enable_long_poll
      end

      def self.directions
        [:forward, :backward]
      end

      StreamNotFoundError = Class.new StandardError

      module Defaults
        def self.batch_size
          batch_size = ENV['EVENT_STORE_HTTP_READ_BATCH_SIZE']

          return batch_size.to_i if batch_size

          20
        end

        def self.direction
          :forward
        end

        def self.position
          0
        end
      end
    end
  end
end
