module EventStore
  module HTTP
    module Requests
      module WriteEvents
        class Batch
          class Event
            include Schema::DataStructure

            attribute :id, String
            attribute :type, String
            attribute :data
            attribute :metadata
          end
        end
      end
    end
  end
end
