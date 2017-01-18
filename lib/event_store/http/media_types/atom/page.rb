module EventStore
  module HTTP
    module MediaTypes
      module Atom
        class Page
          include Schema::DataStructure

          attribute :id, String
          attribute :updated, String
          attribute :stream_id, String
          attribute :links, Hash, default: ->{ Hash.new }
          attribute :entries, Array, default: -> { Array.new }

          Transformer = Embed::None::Transformer
        end
      end
    end
  end
end
