module EventStore
  module HTTP
    module Controls
      module Cluster
        module CurrentMembers
          def self.get
            host = Hostname::Cluster.example
            port = Port.example

            socket = TCPSocket.new host, port
            ip_address = socket.remote_address.ip_address
            socket.close

            leader_ip_address = nil
            follower_ip_addresses = []

            Net::HTTP.start ip_address, port do |connection|
              connection.read_timeout = 0.1

              response = connection.request_get '/gossip', { 'Accept' => 'application/json' }

              fail unless response.code == '200'

              json_text = response.body

              gossip_status = ::JSON.parse json_text

              members = gossip_status['members']

              members.each do |member|
                ip_address = member['externalHttpIp']

                if member['state'] == 'Master'
                  leader_ip_address = ip_address
                else
                  follower_ip_addresses << ip_address
                end
              end
            end

            return leader_ip_address, *follower_ip_addresses
          end
        end
      end
    end
  end
end
