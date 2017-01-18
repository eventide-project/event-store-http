require_relative '../automated_init'

context "Read Stream Using Alternative Transformer" do
  events = 11

  stream, _ = Controls::Write.(events: events)

  read_stream = EventStore::HTTP::ReadStream.build
  read_stream.transformer = Controls::ReadStream::Transformer.example

  page = read_stream.(stream)

  test "Page is deserialized using specfied transformer" do
    control_page = Controls::ReadStream::Transformer::Result.example(
      stream: stream,
      events: events
    )

    assert page == control_page
  end
end
