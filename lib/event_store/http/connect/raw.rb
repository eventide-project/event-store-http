module EventStore
  module HTTP
    module Connect
      class Raw
        include Connect

        setting :keep_alive_timeout
        setting :open_timeout
        setting :read_timeout

        def establish_connection
          net_http host
        end
      end
    end
  end
end
