module EventStore
  module HTTP
    module Controls
      module MediaTypes
        module Atom
          module Event
            module Links
              def self.example(position=nil)
                {
                  :edit => edit(position),
                  :alternate => alternate(position)
                }
              end

              def self.edit(position=nil)
                Event.id position
              end

              def self.alternate(position=nil)
                Event.id position
              end
            end
          end
        end
      end
    end
  end
end
