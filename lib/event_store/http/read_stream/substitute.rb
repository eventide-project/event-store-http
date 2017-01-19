module EventStore
  module HTTP
    class ReadStream
      module Substitute
        def self.build
          ReadStream.build
        end

        class ReadStream
          initializer :telemetry_sink

          attr_accessor :body_embed_enabled
          attr_accessor :long_poll_duration
          attr_accessor :rich_embed_enabled

          dependency :telemetry, ::Telemetry

          def self.build
            telemetry_sink = Telemetry::Sink.new

            instance = new telemetry_sink

            telemetry = ::Telemetry.configure instance
            telemetry.register telemetry_sink

            instance
          end

          def call(stream, position: nil, direction: nil, batch_size: nil)
            unless direction.nil?
              unless EventStore::HTTP::ReadStream.directions.include? direction
                raise ArgumentError
              end
            end

            page = streams.fetch stream do
              raise EventStore::HTTP::ReadStream::StreamNotFoundError
            end

            telemetry.record :read, Telemetry::Read.new(stream, position, direction, batch_size)

            page
          end

          def read?(&block)
            block ||= proc { true }

            telemetry_sink.recorded? do |record|
              block.(*record.data.to_a)
            end
          end

          def enable_long_poll(duration=nil)
            duration ||= HTTP::ReadStream::Defaults.long_poll_duration

            self.long_poll_duration = duration
          end

          def long_poll_enabled?(duration=nil)
            return false if long_poll_duration.nil?
            return true if duration.nil?

            long_poll_duration == duration
          end

          def embed_rich
            self.rich_embed_enabled = true
          end

          def embed_body
            self.body_embed_enabled = true
          end

          def set_response(stream, page, position: nil)
            streams[stream] = page
          end

          def streams
            @streams ||= {}
          end

          alias_method :rich_embed_enabled?, :rich_embed_enabled
          alias_method :body_embed_enabled?, :body_embed_enabled
        end

        module Telemetry
          class Sink
            include ::Telemetry::Sink

            record :read
          end

          Read = Struct.new :stream, :position, :direction, :batch_size
        end
      end
    end
  end
end
