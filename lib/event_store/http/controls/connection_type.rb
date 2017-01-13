module EventStore
  module HTTP
    module Controls
      module ConnectionType
        def self.example
          :any
        end

        def self.connect_class
          EventStore::HTTP::Connect::Any
        end
      end
    end
  end
end
