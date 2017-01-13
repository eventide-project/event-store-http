module EventStore
  module HTTP
    class Session
      include Log::Dependency

      configure :session

      dependency :connect, Connect

      attr_writer :connection

      def self.build(settings=nil, namespace: nil)
        settings ||= Settings.instance
        namespace ||= Array(namespace)

        instance = new
        Connect.configure instance, settings, namespace: namespace
        instance
      end

      def yield(&block)
        block.(connection)
      end

      def connection
        @connection ||= establish_connection
      end

      def establish_connection(ip_address=nil)
        self.connection = connect.(ip_address)
      end
    end
  end
end
