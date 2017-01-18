require_relative '../automated_init'

context "Read Event Using Alternative Transformer" do
  stream, _ = Controls::Write.()

  read_event = EventStore::HTTP::ReadEvent.build
  read_event.transformer = Controls::ReadEvent::Transformer.example

  event = read_event.(stream: stream, position: 0)

  test "Event is deserialized using specfied transformer" do
    control_event = Controls::ReadEvent::Transformer::Result.example

    assert event == control_event
  end
end
