module EventStore
  module HTTP
    module Controls
      module ReadEvent
        module Transformer
          def self.example
            ReadEvent
          end

          def self.json
            self
          end

          def self.instance(raw_data)
            content = raw_data.fetch :content

            type = content.fetch :eventType
            data = Casing::Underscore.(content.fetch(:data))

            { :type => type, :data => data }
          end

          def self.read(text)
            ::JSON.parse text, symbolize_names: true
          end

          module Result
            def self.example
              {
                :type => Event::Type.example,
                :data => Event::Data.example
              }
            end
          end
        end
      end
    end
  end
end
