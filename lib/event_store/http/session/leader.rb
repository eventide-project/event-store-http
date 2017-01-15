module EventStore
  module HTTP
    module Session
      class Leader
        include Session

        def configure
          connect.extend Connect::Leader
        end
      end
    end
  end
end
