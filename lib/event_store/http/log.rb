module EventStore
  module HTTP
    class Log < ::Log
      def tag!(tags)
        tags << :event_store_http
        tags << :library
        tags << :verbose
      end

      class Data < ::Log
        configure_macro :data_logger

        def tag!(tags)
          tags << :event_store_http_data
          tags << :data
        end
      end
    end
  end
end
