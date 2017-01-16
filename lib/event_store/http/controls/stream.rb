module EventStore
  module HTTP
    module Controls
      module Stream
        def self.example
          "testStream-#{Identifier::UUID::Random.get}"
        end
      end
    end
  end
end
