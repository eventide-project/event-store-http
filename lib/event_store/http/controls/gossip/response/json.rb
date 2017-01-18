module EventStore
  module HTTP
    module Controls
      module Gossip
        module Response
          module JSON
            def self.text(unavailable: nil)
              <<-JSON
{
  "members": [
    {
      "instanceId": "00000101-0000-4000-8000-000000000000",
      "timeStamp": "2000-01-01T00:00:00.000000Z",
      "state": "#{unavailable ? 'Unknown' : 'Master'}",
      "isAlive": true,
      "internalTcpIp": "127.0.111.1",
      "internalTcpPort": 1112,
      "internalSecureTcpPort": 0,
      "externalTcpIp": "127.0.111.1",
      "externalTcpPort": 1113,
      "externalSecureTcpPort": 0,
      "internalHttpIp": "127.0.111.1",
      "internalHttpPort": 2112,
      "externalHttpIp": "127.0.111.1",
      "externalHttpPort": 2113,
      "lastCommitPosition": 1111,
      "writerCheckpoint": 111,
      "chaserCheckpoint": 11,
      "epochPosition": 222,
      "epochNumber": 22,
      "epochId": "00000001-0000-4000-8000-000000000000",
      "nodePriority": 0
    },
    {
      "instanceId": "00000102-0000-4000-8000-000000000000",
      "timeStamp": "2000-01-01T00:00:00.000000Z",
      "state": "Slave",
      "isAlive": true,
      "internalTcpIp": "127.0.111.2",
      "internalTcpPort": 1112,
      "internalSecureTcpPort": 0,
      "externalTcpIp": "127.0.111.2",
      "externalTcpPort": 1113,
      "externalSecureTcpPort": 0,
      "internalHttpIp": "127.0.111.2",
      "internalHttpPort": 2112,
      "externalHttpIp": "127.0.111.2",
      "externalHttpPort": 2113,
      "lastCommitPosition": 1111,
      "writerCheckpoint": 111,
      "chaserCheckpoint": 11,
      "epochPosition": 222,
      "epochNumber": 22,
      "epochId": "00000001-0000-4000-8000-000000000000",
      "nodePriority": 0
    },
    {
      "instanceId": "00000103-0000-4000-8000-000000000000",
      "timeStamp": "2000-01-01T00:00:00.000000Z",
      "state": "Slave",
      "isAlive": false,
      "internalTcpIp": "127.0.111.3",
      "internalTcpPort": 1112,
      "internalSecureTcpPort": 0,
      "externalTcpIp": "127.0.111.3",
      "externalTcpPort": 1113,
      "externalSecureTcpPort": 0,
      "internalHttpIp": "127.0.111.3",
      "internalHttpPort": 2112,
      "externalHttpIp": "127.0.111.3",
      "externalHttpPort": 2113,
      "lastCommitPosition": 1111,
      "writerCheckpoint": 111,
      "chaserCheckpoint": 11,
      "epochPosition": 222,
      "epochNumber": 22,
      "epochId": "00000001-0000-4000-8000-000000000000",
      "nodePriority": 0
    }
  ],
  "serverIp": "127.0.111.1",
  "serverPort": 2112
}
              JSON
            end
          end
        end
      end
    end
  end
end
