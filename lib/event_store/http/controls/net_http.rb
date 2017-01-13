module EventStore
  module HTTP
    module Controls
      module NetHTTP
        def self.example
          hostname = Hostname.example
          port = Port.example

          Net::HTTP.new hostname, port
        end
      end
    end
  end
end
