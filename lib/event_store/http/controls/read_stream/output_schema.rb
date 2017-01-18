module EventStore
  module HTTP
    module Controls
      module ReadStream
        module OutputSchema
          def self.example
            self
          end

          module Result
            def self.example(events: nil, stream: nil)
              events ||= 1

              (0...events).to_a.reverse.map do |position|
                URI::Event.raw stream: stream, position: position
              end
            end
          end

          module Transformer
            def self.json
              JSON
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
