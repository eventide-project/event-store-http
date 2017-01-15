module EventStore
  module HTTP
    module Session
      module Read
        def self.get(settings=nil, namespace: nil)
          settings = Settings::Read.get settings, namespace: namespace

          Session.build settings
        end

        def self.configure(receiver, settings=nil, namespace: nil, attr_name: nil, session: nil)
          attr_name ||= :session

          session ||= get settings, namespace: namespace

          receiver.public_send "#{attr_name}=", session
          session
        end
      end
    end
  end
end
