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
    end
  end
end
