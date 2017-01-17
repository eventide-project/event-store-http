module EventStore
  module HTTP
    module Controls
      module MediaTypes
        module Atom
          module Page
            module JSON
              module EmbedRich
                def self.example
                  <<~JSON
                  {
                    "title": "Event stream 'testStream'",
                    "id": "http://127.0.0.1:2113/streams/testStream",
                    "updated": "2000-01-01T00:00:00.000000Z",
                    "streamId": "testStream",
                    "author": {
                      "name": "EventStore"
                    },
                    "headOfStream": true,
                    "links": [
                      {
                        "uri": "http://127.0.0.1:2113/streams/testStream",
                        "relation": "self"
                      },
                      {
                        "uri": "http://127.0.0.1:2113/streams/testStream/head/backward/20",
                        "relation": "first"
                      },
                      {
                        "uri": "http://127.0.0.1:2113/streams/testStream/0/forward/20",
                        "relation": "last"
                      },
                      {
                        "uri": "http://127.0.0.1:2113/streams/testStream/49/backward/20",
                        "relation": "next"
                      },
                      {
                        "uri": "http://127.0.0.1:2113/streams/testStream/70/forward/20",
                        "relation": "previous"
                      },
                      {
                        "uri": "http://127.0.0.1:2113/streams/testStream/metadata",
                        "relation": "metadata"
                      }
                    ],
                    "entries": [
                      {
                        "eventId": "00000002-0000-4000-8000-000000000000",
                        "eventType": "SomeType",
                        "eventNumber": 2,
                        "streamId": "testStream",
                        "isJson": true,
                        "isMetaData": false,
                        "isLinkMetaData": false,
                        "positionEventNumber": 222,
                        "positionStreamId": "readStream",
                        "title": "2@testStream",
                        "id": "http://127.0.0.1:2113/streams/testStream/2",
                        "updated": "2000-01-01T00:00:00.000000Z",
                        "author": {
                          "name": "EventStore"
                        },
                        "summary": "SomeType",
                        "links": [
                          {
                            "uri": "http://127.0.0.1:2113/streams/testStream/2",
                            "relation": "edit"
                          },
                          {
                            "uri": "http://127.0.0.1:2113/streams/testStream/2",
                            "relation": "alternate"
                          }
                        ]
                      },
                      {
                        "eventId": "00000001-0000-4000-8000-000000000000",
                        "eventType": "SomeType",
                        "eventNumber": 1,
                        "streamId": "testStream",
                        "isJson": true,
                        "isMetaData": false,
                        "isLinkMetaData": false,
                        "positionEventNumber": 111,
                        "positionStreamId": "readStream",
                        "title": "1@testStream",
                        "id": "http://127.0.0.1:2113/streams/testStream/1",
                        "updated": "2000-01-01T00:00:00.000000Z",
                        "author": {
                          "name": "EventStore"
                        },
                        "summary": "SomeType",
                        "links": [
                          {
                            "uri": "http://127.0.0.1:2113/streams/testStream/1",
                            "relation": "edit"
                          },
                          {
                            "uri": "http://127.0.0.1:2113/streams/testStream/1",
                            "relation": "alternate"
                          }
                        ]
                      },
                      {
                        "eventId": "00000000-0000-4000-8000-000000000000",
                        "eventType": "SomeType",
                        "eventNumber": 0,
                        "streamId": "testStream",
                        "isJson": true,
                        "isMetaData": false,
                        "isLinkMetaData": false,
                        "positionEventNumber": 0,
                        "positionStreamId": "readStream",
                        "title": "0@testStream",
                        "id": "http://127.0.0.1:2113/streams/testStream/0",
                        "updated": "2000-01-01T00:00:00.000000Z",
                        "author": {
                          "name": "EventStore"
                        },
                        "summary": "SomeType",
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
end
