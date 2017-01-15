module EventStore
  module HTTP
    module NetHTTP
      def self.activate
        Net::HTTP.class_exec do
          const_set :Substitute, Substitute
        end
      end
    end
  end
end
