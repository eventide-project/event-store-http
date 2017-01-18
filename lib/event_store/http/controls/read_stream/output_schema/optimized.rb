module EventStore
  module HTTP
    module Controls
      module ReadStream
        module OutputSchema
          module Optimized
            def self.example
              self
            end

            module Event
              def self.example(id: nil, stream: nil, position: nil, global_position: nil)
                position ||= 0
                global_position ||= position
                id ||= Controls::Event::ID.example position
                stream ||= Stream.example

                type = Controls::Event::Type.example
                data = Controls::Event::Data.example position
                metadata = Controls::Event::Metadata.example position

                Example.new id, type, data, metadata, stream, position, global_position
              end

              Example = Struct.new :id, :type, :data, :metadata, :stream, :position, :global_position
            end

            module Transformer
              def self.json
                JSON
              end

              def self.instance(raw_data)
                raw_data.fetch('entries').map do |entry|
                  id = entry.fetch 'eventId'
                  type = entry.fetch 'eventType'
                  stream = entry.fetch 'streamId'
                  position = entry.fetch 'eventNumber'
                  global_position = entry.fetch 'positionEventNumber'

                  data_text = entry.fetch 'data'
                  data = EventStore::HTTP::JSON::Deserialize.(data_text)

                  metadata_text = entry['metaData']
                  metadata_text = nil if metadata_text == ''

                  unless metadata_text.nil?
                    metadata = EventStore::HTTP::JSON::Deserialize.(metadata_text)
                  end

                  Event::Example.new id, type, data, metadata, stream, position, global_position
                end
              end

              module JSON
                def self.read(text)
                  ::JSON.parse text
                end
              end
            end
          end
        end
      end
    end
  end
end
