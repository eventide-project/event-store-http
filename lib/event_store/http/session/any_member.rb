module EventStore
  module HTTP
    module Session
      class AnyMember
        include Session

        def configure(settings, namespace)
          Connect::Any.configure self, settings, namespace: namespace
        end
      end
    end
  end
end
