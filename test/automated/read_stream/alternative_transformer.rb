require_relative '../automated_init'

context "Read Stream Using Alternative Transformer" do
  events = 11

  transformer = Controls::ReadStream::Transformer.example

  stream, _ = Controls::Write.(events: events)

  read_stream = EventStore::HTTP::ReadStream.build

  page = read_stream.(stream, transformer: transformer)

  test "Page is deserialized using specfied transformer" do
    control_page = Controls::ReadStream::Transformer::Result.example(
      stream: stream,
      events: events
    )

    assert page == control_page
  end
end
