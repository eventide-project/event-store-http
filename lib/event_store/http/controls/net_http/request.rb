module EventStore
  module HTTP
    module Controls
      module NetHTTP
        module Request
          def self.example
            Net::HTTP::Get.new '/info'
          end
        end
      end
    end
  end
end
