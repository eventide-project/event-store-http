module EventStore
  module HTTP
    module Controls
      module ReadEvent
        module OutputSchema
          def self.example
            self
          end

          module Result
            def self.example
              {
                :type => Event::Type.example,
                :data => Event::Data.example
              }
            end
          end

          module Transformer
            def self.json
              JSON
            end

            def self.instance(raw_data)
              content = raw_data.fetch :content

              type = content.fetch :eventType
              data = Casing::Underscore.(content.fetch(:data))

              { :type => type, :data => data }
            end

            module JSON
              def self.read(text)
                ::JSON.parse text, symbolize_names: true
              end
            end
          end
        end
      end
    end
  end
end
