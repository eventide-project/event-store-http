require_relative '../automated_init'

context "Read Event Using Alternative Output Schema" do
  stream, _ = Controls::Write.()

  read_event = EventStore::HTTP::ReadEvent.build
  read_event.output_schema = Controls::ReadEvent::OutputSchema.example

  event = read_event.(stream: stream, position: 0)

  test "Event is deserialized into specfied output schema" do
    control_event = Controls::ReadEvent::OutputSchema::Result.example

    assert event == control_event
  end
end
