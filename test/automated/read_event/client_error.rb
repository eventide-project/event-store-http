require_relative '../automated_init'

context "Read Event, EventStore Responds With Client Error (4xx)" do
  read_event = EventStore::HTTP::ReadEvent.new
  read_event.connection.set_response 400

  uri = Controls::URI::Event.example

  test "Request error is raised" do
    assert proc { read_event.(uri) } do
      raises_error? EventStore::HTTP::ReadEvent::Error
    end
  end
end
