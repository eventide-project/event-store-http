require_relative '../automated_init'

context "Read Stream When Position Exceeds Stream Version" do
  stream, batch = Controls::Write.()

  context "Reading forwards" do
    position = batch.events.count

    read_stream = EventStore::HTTP::ReadStream.build

    result = read_stream.(stream, position: position)

    test "No entries are returned" do
      assert result.entries == []
    end
  end

  context "Reading backwards" do
    position = batch.events.count

    read_stream = EventStore::HTTP::ReadStream.build

    result = read_stream.(stream, batch_size: 2, position: position, direction: :backward)

    test "Entries are returned" do
      assert result.entries.count == 1
    end
  end
end
