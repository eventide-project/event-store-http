module EventStore
  module HTTP
    class Write
      module Substitute
        def self.build
          Write.new
        end

        class Write
          attr_accessor :version

          def call(batch, stream, expected_version: nil)
            if version && expected_version && version != expected_version
              raise ExpectedVersionError
            end

            if expected_version.nil?
              expected_version = -1
              stream_version = version || -1
            else
              stream_version = expected_version
            end

            path = "#{HTTP::Write.stream_path stream}/#{stream_version + 1}"

            location = URI::HTTP.build :path => path

            batch.events.each do |event|
              write_records << Record.new(event, stream, expected_version)
            end

            location
          end

          def write_records
            @write_records ||= [] 
          end

          def written?(&block)
            block ||= proc { true }

            write_records.any? do |record|
              block.(*record.to_a)
            end
          end

          Record = Struct.new :event, :stream, :expected_version
        end
      end
    end
  end
end
