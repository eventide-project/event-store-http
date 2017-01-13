module EventStore
  module HTTP
    class Settings < ::Settings
      def self.instance
        @instance ||= build
      end

      def self.data_source
        'settings/event_store_http.json'
      end

      def self.names
        %i(
          host
          port
          type

          keep_alive_timeout
          open_timeout
          read_timeout

          read_host
        )
      end
    end
  end
end
