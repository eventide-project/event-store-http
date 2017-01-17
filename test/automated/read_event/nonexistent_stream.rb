require_relative '../automated_init'

context "Read Event When Stream Does Not Exist" do
  stream = Controls::Stream.example

  uri = Controls::URI::Event.example stream: stream, position: 11

  test "Error is raised" do
    assert proc { EventStore::HTTP::ReadEvent.(uri) } do
      raises_error? EventStore::HTTP::ReadEvent::EventNotFoundError
    end
  end
end
