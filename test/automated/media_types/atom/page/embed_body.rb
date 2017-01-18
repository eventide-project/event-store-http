require_relative '../../../automated_init'

context "Atom Media Type, Deserializing Page With Body Data Embedded" do
  json_text = Controls::MediaTypes::Atom::Page::JSON::Embed::Body.example

  atom_page = Transform::Read.(json_text, :json, EventStore::HTTP::MediaTypes::Atom::Page::Embed::Body)

  test "Number of entries" do
    assert atom_page.entries.count == Controls::MediaTypes::Atom::Page::Entries.count
  end

  test "Control" do
    control_page = Controls::MediaTypes::Atom::Page.example embed: :body

    assert atom_page == control_page
  end

  atom_page.entries.each_with_index do |entry, index|
    position = Controls::MediaTypes::Atom::Page::Entries.position index

    context "Event @#{position}" do
      test "Data" do
        assert entry.content.data == Controls::Event::Data.example(position)
      end

      test "Metadata" do
        assert entry.content.metadata == Controls::Event::Metadata.example(position)
      end

      test "Event ID" do
        assert entry.event_id == Controls::MediaTypes::Atom::Page::Entries.event_id(index)
      end

      test "Event type" do
        assert entry.content.event_type == Controls::MediaTypes::Atom::Page::Entries.event_type
      end

      test "Event number" do
        assert entry.content.event_number == Controls::MediaTypes::Atom::Page::Entries.event_number(index)
      end

      test "Event stream ID" do
        assert entry.content.event_stream_id == Controls::MediaTypes::Atom::Page::Entries.stream_id
      end

      test "Is JSON" do
        assert entry.json? == Controls::MediaTypes::Atom::Page::Entries.is_json
      end

      test "Is metadata" do
        assert entry.metadata? == Controls::MediaTypes::Atom::Page::Entries.is_metadata
      end

      test "Is link metadata" do
        assert entry.link_metadata? == Controls::MediaTypes::Atom::Page::Entries.is_link_metadata
      end

      test "Position event number" do
        assert entry.position_event_number == Controls::MediaTypes::Atom::Page::Entries.position_event_number(index)
      end

      test "Position stream ID" do
        assert entry.position_stream_id == Controls::MediaTypes::Atom::Page::Entries.position_stream_id
      end
    end
  end
end
