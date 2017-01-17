require_relative '../../automated_init'

context "Read Event Substitute" do
  substitute = SubstAttr::Substitute.build EventStore::HTTP::ReadEvent

  stream = Controls::Stream.example
  position = 1
  control_event = Controls::MediaTypes::Atom::Event.example

  substitute.set_response control_event, stream, position

  context "URI is specified" do
    uri = Controls::URI::Event.example stream: stream, position: position

    event = substitute.(uri)

    test "Event is returned" do
      assert event == control_event
    end
  end

  context "Position and stream are specified" do
    event = substitute.(stream: stream, position: position)

    test "Event is returned" do
      assert event == control_event
    end
  end

  context "Position does not match" do
    uri = Controls::URI::Event.example stream: stream, position: position.next

    test "EventNotFoundError is raised" do
      assert proc { substitute.(uri) } do
        raises_error? EventStore::HTTP::ReadEvent::EventNotFoundError
      end
    end
  end

  context "Stream does not match" do
    other_stream = Controls::Stream.example

    uri = Controls::URI::Event.example stream: other_stream, position: position

    test "EventNotFoundError is raised" do
      assert proc { substitute.(uri) } do
        raises_error? EventStore::HTTP::ReadEvent::EventNotFoundError
      end
    end
  end
end
