module EventStore
  module HTTP
    module Connect
      def self.included(cls)
        cls.class_exec do
          include Log::Dependency
          prepend Call

          setting :host
          setting :port

          setting :keep_alive_timeout
          setting :open_timeout
          setting :read_timeout

          def port
            @port ||= Defaults.port
          end

          extend Build
        end
      end

      def self.build(settings=nil, namespace: nil, type: nil)
        Factory.(settings, namespace: namespace, type: type)
      end

      def self.call(settings=nil, **arguments)
        instance = build settings, **arguments
        instance.()
      end

      def self.configure(receiver, settings=nil, attr_name: nil, **arguments)
        attr_name ||= :connect

        instance = build settings, **arguments
        receiver.public_send "#{attr_name}=", instance
        instance
      end

      def self.configure_connection(receiver, settings=nil, connection: nil, attr_name: nil, **arguments)
        attr_name ||= :connection

        connection ||= self.(settings, **arguments)
        receiver.public_send "#{attr_name}=", connection
        connection
      end

      module Call
        def call(ip_address=nil)
          if ip_address.nil?
            super()
          else
            raw ip_address
          end
        end
      end

      Virtual::Method.define self, :configure

      Virtual::PureMethod.define self, :call

      def raw(ip_address)
        logger.trace { "Building Net::HTTP connection (IPAddress: #{ip_address}, Port: #{port})" }

        net_http = Net::HTTP.new ip_address, port
        net_http.keep_alive_timeout = keep_alive_timeout unless keep_alive_timeout.nil?
        net_http.open_timeout = open_timeout unless open_timeout.nil?
        net_http.read_timeout = read_timeout unless read_timeout.nil?

        logger.trace { "Net::HTTP connection built (IPAddress: #{ip_address}, Port: #{port})" }

        net_http.extend NetHTTP::Extensions

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