require_relative '../automated_init'

context "Read Stream, Body Embed" do
  read_stream = EventStore::HTTP::ReadStream.build
  read_stream.embed_body

  context "Metadata is not included" do
    stream, _ = Controls::Write.(events: 11)

    page = read_stream.(stream, batch_size: Controls::MediaTypes::Atom::Page::Entries.count)

    context "Page entries" do
      page.entries.each_with_index do |entry, index|
        position = Controls::MediaTypes::Atom::Page::Entries.position index

        context "Entry ##{index}" do
          test "Data" do
            assert entry.content.data == Controls::Event::Data.example(position)
          end

          test "Metadata" do
            assert entry.content.metadata == nil
          end

          test "Event ID" do
            assert Identifier::UUID::Pattern::TYPE_4.match(entry.event_id)
          end

          test "Event type" do
            assert entry.content.event_type == Controls::Event::Type.example
          end

          test "Event number" do
            assert entry.content.event_number == Controls::MediaTypes::Atom::Page::Entries.event_number(index)
          end

          test "Event stream ID" do
            assert entry.content.event_stream_id == stream
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

  context "Metadata is included" do
    stream, _ = Controls::Write.(events: 11, metadata: true)

    page = read_stream.(stream, batch_size: Controls::MediaTypes::Atom::Page::Entries.count)

    context "Page entries" do
      page.entries.each_with_index do |entry, index|
        position = Controls::MediaTypes::Atom::Page::Entries.position index

        context "Entry ##{index}" do
          test "Metadata" do
            assert entry.content.metadata == Controls::Event::Metadata.example(position)
          end
        end
      end
    end
  end
end
