module EventStore
  module HTTP
    module Controls
      module MediaTypes
        module Atom
          module Page
            module Links
              def self.example(backward: nil)
                hash = {
                  :self => self.self,
                  :first => first,
                  :last => last,
                  :metadata => metadata
                }

                if backward
                  hash.merge!({
                    :previous => Backward.previous,
                    :next => Backward.next,
                  })
                else
                  hash.merge!({
                    :previous => self.previous,
                    :next => self.next,
                  })
                end

                hash
              end

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
          end
        end
      end
    end
  end
end
