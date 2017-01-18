module EventStore
  module HTTP
    module JSON
      module Serialize
        def self.call(data, pretty_generate: nil)
          if pretty_generate
            method = :pretty_generate
          else
            method = :generate
          end

          data = Casing::Camel.(data)

          ::JSON.public_send method, data
        end
      end
    end
  end
end

