module EventStore
  module HTTP
    module Controls
      module MediaTypes
        module Atom
          module Page
            module Entries
              def self.example(index=nil)
                position = position index

                Event.example index
              end

              def self.count
                3
              end

              def self.position(index=nil)
                index ||= 0

                count - index - 1
              end

              def self.title(index=nil)
                position = self.position index

                Event.title position
              end

              def self.id(index=nil)
                position = self.position index

                Event.id position
              end

              def self.summary
                Event.summary
              end

              module Links
                def self.example(index=nil)
                  position = Entries.position index

                  Event::Links.example position
                end

                def self.edit(index=nil)
                  position = Entries.position index

                  Event::Links.edit position
                end

                def self.alternate(index=nil)
                  position = Entries.position index

                  Event::Links.alternate position
                end
              end
            end
          end
        end
      end
    end
  end
end
