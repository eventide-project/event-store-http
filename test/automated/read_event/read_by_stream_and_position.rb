require_relative '../automated_init'

context "Read Event By Stream And Position" do
  stream, _ = Controls::Write.(events: 1)
  position = 0

  context "Stream and position are specified" do
    atom_event = EventStore::HTTP::ReadEvent.(stream: stream, position: position)

    test "Event is returned" do
      assert atom_event.instance_of?(EventStore::HTTP::MediaTypes::Atom::Event)
    end
  end

  context "Stream is not specified" do
    test "Argument error is raised" do
      assert proc { EventStore::HTTP::ReadEvent.(position: position) } do
        raises_error? ArgumentError
      end
    end
  end

  context "Position is not specified" do
    test "Argument error is raised" do
      assert proc { EventStore::HTTP::ReadEvent.(stream: stream) } do
        raises_error? ArgumentError
      end
    end
  end
end
