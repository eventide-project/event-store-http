require_relative '../../../automated_init'

context "Atom Media Type, Deserializing Event" do
  json_text = Controls::MediaTypes::Atom::Event::JSON.example

  atom_event = Transform::Read.(json_text, :json, EventStore::HTTP::MediaTypes::Atom::Event)

  test "Title" do
    assert atom_event.title == Controls::MediaTypes::Atom::Event.title
  end

  test "ID" do
    assert atom_event.id == Controls::MediaTypes::Atom::Event.id
  end

  test "Summary" do
    assert atom_event.summary == Controls::MediaTypes::Atom::Event.summary
  end

  test "Edit link" do
    assert atom_event.links[:edit] == Controls::MediaTypes::Atom::Event::Links.edit
  end

  test "Alternate link" do
    assert atom_event.links[:alternate] == Controls::MediaTypes::Atom::Event::Links.alternate
  end

  context "Content" do
    content = atom_event.content

    test "Event stream ID" do
      assert content.event_stream_id == Controls::MediaTypes::Atom::Event::Content.event_stream_id
    end

    test "Event number" do
      assert content.event_number == Controls::MediaTypes::Atom::Event::Content.event_number
    end

    test "Event type" do
      assert content.event_type == Controls::Event::Type.example
    end

    test "Data" do
      assert content.data == Controls::Event::Data.example
    end

    test "Metadata is not set" do
      assert content.metadata == nil
    end
  end
end
