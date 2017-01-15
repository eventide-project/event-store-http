require_relative '../automated_init'

context "Session Type Is Selected" do
  context "Type is not specified" do
    connect = EventStore::HTTP::Session.build

    test "Leader connection type is selected" do
      assert connect.instance_of?(EventStore::HTTP::Session::Leader)
    end
  end

  context "Any member type" do
    connect = EventStore::HTTP::Session.build type: :any_member

    test do
      assert connect.instance_of?(EventStore::HTTP::Session::AnyMember)
    end
  end

  context "Unknown type" do
    test "Error is raised" do
      assert proc { EventStore::HTTP::Session.build type: 'unknown' } do
        raises_error? EventStore::HTTP::Session::Factory::UnknownType
      end
    end
  end
end
