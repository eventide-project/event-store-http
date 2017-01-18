require_relative '../automated_init'

context "Read Stream Using Alternative Output Schema" do
  events = 11

  stream, _ = Controls::Write.(events: events)

  read_stream = EventStore::HTTP::ReadStream.build
  read_stream.output_schema = Controls::ReadStream::OutputSchema.example

  page = read_stream.(stream)

  test "Page is deserialized into specfied output schema" do
    control_page = Controls::ReadStream::OutputSchema::Result.example(
      stream: stream,
      events: events
    )

    assert page == control_page
  end
end
