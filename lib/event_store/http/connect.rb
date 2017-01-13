module EventStore
  module HTTP
    module Connect
      def self.included(cls)
        cls.class_exec do
          include Log::Dependency

          setting :host
          setting :port

          def port
            @port ||= Defaults.port
          end

          extend Build
        end
      end

      def self.build(settings=nil, **arguments)
        Factory.(settings, **arguments)
      end

      def call(ip_address=nil)
        if ip_address.nil?
          establish_connection
        else
          net_http ip_address
        end
      end

      Virtual::Method.define self, :configure

      Virtual::PureMethod.define self, :establish_connection

      def net_http(ip_address)
        logger.trace { "Building Net::HTTP connection (IPAddress: #{ip_address}, Port: #{port})" }

        net_http = Net::HTTP.new ip_address, port

        logger.trace { "Net::HTTP connection built (IPAddress: #{ip_address}, Port: #{port})" }

        net_http
      end

      module Build
        def build(settings=nil, namespace: nil)
          settings ||= Settings.instance
          namespace ||= Array(namespace)

          instance = new
          settings.set instance, namespace
          instance.configure
          instance
        end
      end
    end
  end
end
