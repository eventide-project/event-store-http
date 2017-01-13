module EventStore
  module HTTP
    module Controls
      module Request
        def self.example
          Net::HTTP::Get.new '/info', { 'Accept' => 'application/json' }
        end
      end
    end
  end
end
