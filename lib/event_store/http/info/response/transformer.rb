module EventStore
  module HTTP
    module Requests
      module Info
        class Response
          module Transformer
            def self.json
              JSON
            end

            def self.instance(raw_data)
              response = Response.new
              response.event_store_version = raw_data[:es_version]
              response.state = raw_data[:state]
              response.projections_mode = raw_data[:projections_mode]
              response
            end

            module JSON
              def self.read(json_text)
                formatted_data = ::JSON.parse json_text, :symbolize_names => true
                Casing::Underscore.(formatted_data)
              end
            end
          end
        end
      end
    end
  end
end
