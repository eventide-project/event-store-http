require_relative '../automated_init'

context "Read Stream Using Alternative Optimized Output Schema" do
  stream, batch = Controls::Write.(metadata: true)

  read_stream = EventStore::HTTP::ReadStream.build
  read_stream.embed_body
  read_stream.output_schema = Controls::ReadStream::OutputSchema::Optimized.example

  event, * = read_stream.(stream)

  test "Event is deserialized into output schema" do
    event_id = batch.events[0].id

    control_event = Controls::ReadStream::OutputSchema::Optimized::Event.example(
      id: event_id,
      stream: stream
    )

    assert event == control_event
  end
end
