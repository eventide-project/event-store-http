module EventStore
  module HTTP
    module Controls
      module NetHTTP
        def self.example(host: nil)
          host ||= Hostname.example
          port = Port.example

          Net::HTTP.new host, port
        end
      end
    end
  end
end
