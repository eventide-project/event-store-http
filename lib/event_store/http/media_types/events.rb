module EventStore
  module HTTP
    module MediaTypes
      module Events
        def self.mime
          "application/vnd.eventstore.events+json"
        end
      end
    end
  end
end
