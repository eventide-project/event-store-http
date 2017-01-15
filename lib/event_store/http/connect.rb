module EventStore
  module HTTP
    class Connect
      include Log::Dependency

      configure :connect

      setting :host
      setting :port

      setting :keep_alive_timeout
      setting :open_timeout
      setting :read_timeout

      def port
        @port ||= Defaults.port
      end

      def self.build(settings=nil, namespace: nil)
        settings ||= Settings.instance
        namespace ||= Array(namespace)

        instance = new
        settings.set instance, namespace
        instance
      end

      def self.call(ip_address=nil, settings: nil, namespace: nil)
        instance = build settings, namespace: namespace
        instance.(ip_address)
      end

      def self.configure_connection(receiver, settings=nil, connection: nil, attr_name: nil, **arguments)
        attr_name ||= :connection

        connection ||= self.(settings: settings, **arguments)
        receiver.public_send "#{attr_name}=", connection
        connection
      end

      def call(ip_address=nil)
        if ip_address.nil?
          connect
        else
          raw ip_address
        end
      end

      def connect
        raw host
      end

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
    end
  end
end
