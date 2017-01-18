require_relative '../automated_init'

context "Read Event Using Alternative Transformer" do
  transformer = Controls::ReadEvent::Transformer.example

  stream, _ = Controls::Write.()

  read_event = EventStore::HTTP::ReadEvent.build

  event = read_event.(stream: stream, position: 0, transformer: transformer)

  test "Event is deserialized using specfied transformer" do
    control_event = Controls::ReadEvent::Transformer::Result.example

    assert event == control_event
  end
end
