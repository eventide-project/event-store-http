module EventStore
  module HTTP
    module Controls
      module MediaTypes
        module Atom
          module Page
            module Entries
              def self.example(index=nil)
                page = EventStore::HTTP::MediaTypes::Atom::Page.new
                page.title = title index
                page.id = id index
                page.summary = summary
                page.links = Links.example index

                (0...Entries.count).each do |index|
                  entry = Entry.example index

                  page.entries << entry
                end

                page
              end

              def self.count
                3
              end

              def self.position(index=nil)
                index ||= 0

                count - index - 1
              end

              def self.title(index=nil)
                "#{position index}@testStream"
              end

              def self.id(index=nil)
                "http://#{Controls::IPAddress.example}:#{Port.example}/streams/#{Page.stream}/#{position index}"
              end

              def self.summary
                Event::Type.example
              end

              module Links
                def self.example(index=nil)
                  {
                    :edit => edit(index),
                    :alternate => alternate(index)
                  }
                end

                def self.edit(index=nil)
                  Entries.id index
                end

                def self.alternate(index=nil)
                  Entries.id index
                end
              end
            end
          end
        end
      end
    end
  end
end
