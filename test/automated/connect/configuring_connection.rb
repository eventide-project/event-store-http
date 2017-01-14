require_relative '../automated_init'

context "Connect Configures Connection" do
  context "Attribute name is not specified" do
    receiver = OpenStruct.new

    connection = EventStore::HTTP::Connect.configure_connection receiver

    test "Default attribute name is used" do
      assert receiver.connection == connection
    end

    test "Net::HTTP connection is returned" do
      assert connection.instance_of?(Net::HTTP)
    end
  end

  context "Attribute name is specified" do
    receiver = OpenStruct.new

    connection = EventStore::HTTP::Connect.configure_connection receiver, attr_name: :some_attr

    test "Default attribute name is used" do
      assert receiver.some_attr == connection
    end
  end

  context "Settings are specified" do
    receiver = OpenStruct.new

    host = Controls::Hostname::Other.example
    settings = Settings.build({ :host => host })

    connection = EventStore::HTTP::Connect.configure_connection receiver, settings

    test "Settings are applied to connection" do
      assert connection.address == host
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

    connection = EventStore::HTTP::Connect.configure_connection receiver, settings, namespace: :some_namespace

    test "Settings namespace is applied to connection" do
      assert connection.address == host
    end
  end

  context "Connection is supplied" do
    receiver = OpenStruct.new

    connection = Controls::NetHTTP.example

    EventStore::HTTP::Connect.configure_connection receiver, connection: connection

    test "Specified connection is set on receiver" do
      assert receiver.connection.equal?(connection)
    end
  end
end
