require_relative '../automated_init'

context "Connect Configures Dependency" do
  context "Attribute name is not specified" do
    receiver = OpenStruct.new

    connect = EventStore::HTTP::Connect.configure receiver

    test "Default attribute name is used" do
      assert receiver.connect == connect
    end

    test "Connect instance is returned" do
      assert connect.is_a?(EventStore::HTTP::Connect)
    end
  end

  context "Attribute name is specified" do
    receiver = OpenStruct.new

    connect = EventStore::HTTP::Connect.configure receiver, attr_name: :some_attr

    test "Default attribute name is used" do
      assert receiver.some_attr == connect
    end
  end

  context "Settings are specified" do
    receiver = OpenStruct.new

    host = Controls::Hostname::Other.example
    settings = Settings.build({ :host => host })

    connect = EventStore::HTTP::Connect.configure receiver, settings

    test "Settings are applied to connect" do
      assert connect.host == host
    end
  end

  context "Settings namespace is specified" do
    receiver = OpenStruct.new

    host = Controls::Hostname::Other.example
    settings = Settings.build({
      :some_namespace => {
        :host => host
      }
    })

    connect = EventStore::HTTP::Connect.configure receiver, settings, namespace: :some_namespace

    test "Settings namespace is applied to connect" do
      assert connect.host == host
    end
  end
end
