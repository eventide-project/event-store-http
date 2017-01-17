module EventStore
  module HTTP
    module MediaTypes
      module Atom
        module Links
          def self.set(target, links)
            links.each do |hash|
              uri = hash.fetch :uri
              relation = hash.fetch :relation

              target[relation.to_sym] = uri
            end
          end
        end
      end
    end
  end
end
