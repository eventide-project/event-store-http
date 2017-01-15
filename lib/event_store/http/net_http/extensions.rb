module EventStore
  module HTTP
    module NetHTTP
      module Extensions
        def self.extended(net_http)
          net_http.instance_exec do
            extend DefaultHostHeader
            extend IPAddress
          end
        end

        module DefaultHostHeader
          def addr_port
            "#{ip_address}:#{port}"
          end
        end

        module IPAddress
          def ip_address
            if @socket.instance_of? Net::BufferedIO
              socket = @socket.io

              remote_address = socket.remote_address

              remote_address.ip_address
            else
              nil
            end
          end
        end
      end
    end
  end
end
