require_relative '../../automated_init'

context "Read Event Substitute, No Event Is Set" do
  substitute = SubstAttr::Substitute.build EventStore::HTTP::ReadEvent

  uri = Controls::URI::Event.example

  test "EventNotFound error is raised" do
    assert proc { substitute.(uri) } do
      raises_error? EventStore::HTTP::ReadEvent::EventNotFoundError
    end
  end
end
