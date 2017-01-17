module EventStore
  module HTTP
    module Controls
      module MediaTypes
        module Atom
          module Page
            def self.stream
              Stream.example random: false
            end

            def self.id
              "http://#{Controls::IPAddress.example}:#{Port.example}/streams/#{stream}"
            end

            def self.updated
              Controls::Time::Raw.example.iso8601 6
            end

            def self.stream_id
              stream
            end

            module Links
              def self.self
                "http://127.0.0.1:2113/streams/testStream"
              end

              def self.first
                "http://127.0.0.1:2113/streams/testStream/head/backward/20"
              end

              def self.last
                "http://127.0.0.1:2113/streams/testStream/0/forward/20"
              end

              def self.next
                "http://127.0.0.1:2113/streams/testStream/49/backward/20"
              end

              def self.previous
                "http://127.0.0.1:2113/streams/testStream/70/forward/20"
              end

              def self.metadata
                "http://127.0.0.1:2113/streams/testStream/metadata"
              end

              module Backward
                def self.next
                  "http://127.0.0.1:2113/streams/testStream/30/backward/20"
                end

                def self.previous
                  "http://127.0.0.1:2113/streams/testStream/51/forward/20"
                end
              end
            end

            module Entries
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
