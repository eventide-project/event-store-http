module EventStore
  module HTTP
    class ReadEvent
      include Log::Dependency
      include Request

      configure :read_event

      def call(uri)
        request = Net::HTTP::Get.new uri
        request['Accept'] = MediaTypes::Atom.mime

        response = connection.request request

        puts response.body

        Transform::Read.(response.body, :json, MediaTypes::Atom::Event)
      end
    end
  end
end
