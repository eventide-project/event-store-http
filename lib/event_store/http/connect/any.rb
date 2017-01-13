module EventStore
  module HTTP
    module Connect
      class Any
        include Connect

        def call
          raw host
        end
      end
    end
  end
end
