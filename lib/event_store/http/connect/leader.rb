module EventStore
  module HTTP
    module Connect
      class Leader
        include Connect

        def call
          net_http = raw host

          # XXX sham implementation
          net_http.start do
            request = Net::HTTP::Get.new '/info'
            request['Accept'] = 'application/json'

            http_response = net_http.request request

            response = JSON.parse http_response.body

            break if response['state'] == 'master'

            request = Net::HTTP::Get.new '/gossip'

            request['Accept'] = 'application/json'

            http_response = net_http.request request

            response = JSON.parse http_response.body

            leader_ip_address = response['members'].select { |member| member['state'] == 'Master' }[0]['externalHttpIp']

            net_http = raw leader_ip_address
          end
          # /XXX sham implementation

          net_http
        end
      end
    end
  end
end
