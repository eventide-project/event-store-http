module EventStore
  module HTTP
    module MediaTypes
      module Atom
        class Page
          include Schema::DataStructure

          attribute :id, String
          attribute :updated, String
          attribute :stream_id, String
          attribute :self_url, String
          attribute :etag, String
          attribute :links, Hash, default: ->{ Hash.new }
          attribute :entries, Array, default: -> { Array.new }
        end
      end
    end
  end
end
