module EventStore
  module HTTP
    module Controls
      module Stream
        def self.example(random: nil)
          random = true if random.nil?

          if random
            "testStream-#{Identifier::UUID::Random.get}"
          else
            "testStream"
          end
        end
      end
    end
  end
end
