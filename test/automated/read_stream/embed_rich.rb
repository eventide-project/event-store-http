require_relative '../automated_init'

context "Read Stream, Rich Embed" do
  stream, _ = Controls::Write.(events: 11)

  read_stream = EventStore::HTTP::ReadStream.build
  read_stream.enable_rich_embed

  page = read_stream.(stream, batch_size: Controls::MediaTypes::Atom::Page::Entries.count)

  context "Page entries" do
    page.entries.each_with_index do |entry, index|
      context "Entry ##{index}" do
        test "Event ID" do
          assert Identifier::UUID::Pattern::TYPE_4.match(entry.event_id)
        end

        test "Event type" do
          assert entry.event_type == Controls::Event::Type.example
        end

        test "Event number" do
          assert entry.event_number == Controls::MediaTypes::Atom::Page::Entries.event_number(index)
        end

        test "Stream ID" do
          assert entry.stream_id == stream
        end

        test "Position event number" do
          assert entry.position_event_number == Controls::MediaTypes::Atom::Page::Entries.event_number(index)
        end

        test "Position stream ID" do
          assert entry.position_stream_id == stream
        end
      end
    end
  end
end
