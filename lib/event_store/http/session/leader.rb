module EventStore
  module HTTP
    module Session
      class Leader
        include Session

        def configure(settings, namespace)
          Connect::Leader.configure self, settings, namespace: namespace
        end
      end
    end
  end
end
