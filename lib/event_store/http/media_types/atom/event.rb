module EventStore
  module HTTP
    module MediaTypes
      module Atom
        class Event
          include Schema::DataStructure

          attribute :title, String
          attribute :id, String
          attribute :updated, String
          attribute :summary, String
          attribute :links, Hash, default: ->{ Hash.new }

          class Content
            include Schema::DataStructure

            attribute :event_stream_id, String
            attribute :event_number, Integer
            attribute :event_type, String
            attribute :data, Hash
            attribute :metadata, Hash
          end
          attribute :content, Content
        end
      end
    end
  end
end
