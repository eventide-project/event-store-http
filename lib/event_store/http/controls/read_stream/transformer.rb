module EventStore
  module HTTP
    module Controls
      module ReadStream
        module Transformer
          def self.example
            ReadStream
          end

          def self.json
            self
          end

          def self.instance(raw_data)
            raw_data.fetch('entries').map do |entry|
              edit_link = nil

              entry['links'].each do |link|
                if link.fetch('relation') == 'edit'
                  edit_link = link.fetch 'uri'
                  break
                end
              end

              edit_link
            end
          end

          def self.read(text)
            ::JSON.parse text
          end

          module Result
            def self.example(events: nil, stream: nil)
              events ||= 1

              (0...events).to_a.reverse.map do |position|
                URI::Event.raw stream: stream, position: position
              end
            end
          end
        end
      end
    end
  end
end
