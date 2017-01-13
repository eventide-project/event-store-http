require_relative '../automated_init'

context "Settings" do
  context "Port" do
    settings = Settings.build({ :port => 1111, :type => :any })

    connect = EventStore::HTTP::Connect.build settings

    test "Port is set on connections" do
      connection = connect.()

      assert connection.port == 1111
    end
  end

  context "Type" do
    settings = Settings.build({ :type => Controls::ConnectionType.example })

    connect = EventStore::HTTP::Connect.build settings

    test "Implementation corresponding to specified type is selected" do
      assert connect.instance_of?(Controls::ConnectionType.connect_class)
    end
  end

  context "Namespace" do
    settings = Settings.build({
      :some_namespace => {
        :host => Controls::Hostname::Other.example
      }
    })

    connect = EventStore::HTTP::Connect.build settings, namespace: :some_namespace

    test "Settings from namespace are applied" do
      assert connect.host == Controls::Hostname::Other.example
    end
  end
end
