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

          attribute :event_id, String

          attribute :is_json
          alias_method :json?, :is_json

          attribute :is_metadata
          alias_method :metadata?, :is_metadata

          attribute :is_link_metadata
          alias_method :link_metadata?, :is_link_metadata

          attribute :position_event_number, Integer
          attribute :position_stream_id, String

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
