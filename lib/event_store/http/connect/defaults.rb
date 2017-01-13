module EventStore
  module HTTP
    module Connect
      module Defaults
        def self.port
          2113
        end

        def self.type
          :any
        end
      end
    end
  end
end
