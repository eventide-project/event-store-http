module EventStore
  module HTTP
    module Controls
      module MediaTypes
        module Events
          module JSON
            def self.text
              <<~JSON.chomp
              [
                {
                  "eventId": "#{UUID.example}",
                  "eventType": "#{Event::Type.example}",
                  "data": {
                    "someAttribute": "some-value-0"
                  }
                }
              ]
              JSON
            end
          end
        end
      end
    end
  end
end
