require_relative '../automated_init'

context "Read Stream" do
  stream, _ = Controls::Write.(events: 11)

  read_stream = EventStore::HTTP::ReadStream.build

  results = read_stream.(stream)

  test "Events are returned" do
    assert results.entries.count == 11
  end
end
