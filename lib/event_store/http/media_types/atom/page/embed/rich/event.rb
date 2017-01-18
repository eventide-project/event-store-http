module EventStore
  module HTTP
    module MediaTypes
      module Atom
        class Page
          module Embed
            module Rich
              module Event
                def self.extended(event)
                  event.singleton_class.class_exec do
                    attribute :event_id, String

                    attribute :is_json
                    alias_method :json?, :is_json

                    attribute :is_metadata
                    alias_method :metadata?, :is_metadata

                    attribute :is_link_metadata
                    alias_method :link_metadata?, :is_link_metadata

                    attribute :position_event_number, Integer
                    attribute :position_stream_id, String
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
