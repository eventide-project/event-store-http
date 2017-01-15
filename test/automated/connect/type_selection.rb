require_relative '../automated_init'

context "Connection Type Is Selected" do
  context "Type is not specified" do
    connect = EventStore::HTTP::Connect.build

    test "Leader connection type is selected" do
      assert connect.instance_of?(EventStore::HTTP::Connect::Leader)
    end
  end

  context "Any type" do
    connect = EventStore::HTTP::Connect.build type: :any_member

    test do
      assert connect.instance_of?(EventStore::HTTP::Connect::Any)
    end
  end

  context "Unknown type" do
    test "Error is raised" do
      assert proc { EventStore::HTTP::Connect.build type: 'unknown' } do
        raises_error? EventStore::HTTP::Connect::Factory::UnknownType
      end
    end
  end
end
