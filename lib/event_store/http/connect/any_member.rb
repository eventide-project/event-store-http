module EventStore
  module HTTP
    module Connect
      class Any
        include Connect

        def self.configure_connection(receiver, settings=nil, connection: nil, attr_name: nil, **arguments)
          attr_name ||= :connection

          connection ||= self.(settings: settings, **arguments)
          receiver.public_send "#{attr_name}=", connection
          connection
        end

        def call
          raw host
        end
      end
    end
  end
end
