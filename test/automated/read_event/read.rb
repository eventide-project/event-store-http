require_relative '../automated_init'

context "Read Event" do
  stream, _ = Controls::Write.(events: 1)

  uri = Controls::URI::Event.example stream: stream, position: 0

  atom_event = EventStore::HTTP::ReadEvent.(uri)

  test "Event is returned" do
    assert atom_event.instance_of?(EventStore::HTTP::MediaTypes::Atom::Event)
  end
end
