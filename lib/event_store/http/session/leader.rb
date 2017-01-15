module EventStore
  module HTTP
    module Session
      class Leader
        include Session

        def configure
          connect.extend Connect::Leader
        end

        def request(request)
          request['ES-RequireMaster'] ||= 'True'

          response = super

          if Net::HTTPRedirection === response
            location = URI.parse response['location']

            leader_ip_address = location.host

            net_http = reconnect leader_ip_address

            request['host'] = nil
            request['connection'] = nil

            response = request request
          end

          response
        end
      end
    end
  end
end
