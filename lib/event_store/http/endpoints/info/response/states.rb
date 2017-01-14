module EventStore
  module HTTP
    module Endpoints
      module Info
        class Response
          module States
            def self.leader
              'master'
            end

            def self.follower
              'slave'
            end

            def self.digest(value)
              case value
              when leader then 'leader'
              when follower then 'follower'
              end
            end
          end
        end
      end
    end
  end
end
