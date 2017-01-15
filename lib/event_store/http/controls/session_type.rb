module EventStore
  module HTTP
    module Controls
      module SessionType
        def self.example
          :any_member
        end

        def self.session_class
          EventStore::HTTP::Session::AnyMember
        end
      end

      #XXX
      module ConnectionType
        def self.example
          SessionType.example
        end

        def self.connect_class
          EventStore::HTTP::Connect::Any
        end
      end
    end
  end
end
