module EventStore
  module HTTP
    module Controls
      module NetHTTP
        module Request
          module Post
            def self.example
              stream_name = "testStream-#{SecureRandom.hex 7}"

              request = Net::HTTP::Post.new "/streams/#{stream_name}"
              request.body = text
              request['es-eventid'] = Identifier::UUID::Random.get
              request['es-eventtype'] = type
              request['content-type'] = 'application/json'
              request
            end

            def self.type
              'SomeEvent'
            end

            def self.data
              {
                :attribute => SecureRandom.hex(7)
              }
            end

            def self.text
              JSON.generate data
            end
          end
        end
      end
    end
  end
end
