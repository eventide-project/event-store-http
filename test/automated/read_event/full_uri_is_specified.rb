require_relative '../automated_init'

context "Read Event" do
  context "Full URI is specified" do
    uri = Controls::URI::Event.example position: 0

    read_event = EventStore::HTTP::ReadEvent.build

    net_http = SubstAttr::Substitute.(:connection, read_event)
    net_http.set_response 200, body: Controls::MediaTypes::Atom::Event::JSON.text

    read_event.(uri.to_s)

    test "URI path is supplied as request location" do
      assert net_http.telemetry_sink do
        recorded_requested? do |record|
          record.data.request.path == uri.path
        end
      end
    end
  end
end
