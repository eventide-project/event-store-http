require_relative '../../../automated_init'

context "Atom Media Type, Deserializing Event With Metadata" do
  json_text = Controls::MediaTypes::Atom::Event::JSON.text metadata: true

  atom_event = Transform::Read.(json_text, :json, EventStore::HTTP::MediaTypes::Atom::Event)

  context "Content" do
    content = atom_event.content

    test "Metadata" do
      assert content.metadata == Controls::MediaTypes::Atom::Event::Content.metadata
    end
  end
end
