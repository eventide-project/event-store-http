module EventStore
  module HTTP
    module MediaTypes
      module Events
        module Serialization
          module JSON
            def self.write(raw_data)
              formatted_data = Casing::Camel.(raw_data, :symbol_to_string => true)
              ::JSON.pretty_generate formatted_data
            end
          end
        end
      end
    end
  end
end
