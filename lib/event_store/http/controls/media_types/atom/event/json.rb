module EventStore
  module HTTP
    module Controls
      module MediaTypes
        module Atom
          module Event
            module JSON
              def self.text(metadata: nil)
                if metadata == true
                  metadata = Controls::Event::Metadata.text
                elsif !metadata
                  metadata = '""'
                end

                data = Controls::Event::Data.text

                <<~JSON
                {
                  "title": "0@testStream",
                  "id": "http://127.0.0.1:2113/streams/testStream/0",
                  "updated": "2000-01-01T00:00:00.000000Z",
                  "author": {
                    "name": "EventStore"
                  },
                  "summary": "SomeType",
                  "content": {
                    "eventStreamId": "testStream",
                    "eventNumber": 0,
                    "eventType": "SomeType",
                    "data": #{data},
                    "metadata": #{metadata}
                  },
                  "links": [
                    {
                      "uri": "http://127.0.0.1:2113/streams/testStream/0",
                      "relation": "edit"
                    },
                    {
                      "uri": "http://127.0.0.1:2113/streams/testStream/0",
                      "relation": "alternate"
                    }
                  ]
                }
                JSON
              end
            end
          end
        end
      end
    end
  end
end
