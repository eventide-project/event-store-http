require_relative '../automated_init'

context "Session Configures Dependency" do
  context "Attribute name is not specified" do
    receiver = OpenStruct.new

    session = EventStore::HTTP::Session.configure receiver

    test "Default attribute name is used" do
      assert receiver.session == session
    end

    test "Connect instance is returned" do
      assert session.is_a?(EventStore::HTTP::Session)
    end
  end

  context "Attribute name is specified" do
    receiver = OpenStruct.new

    session = EventStore::HTTP::Session.configure receiver, attr_name: :some_attr

    test "Default attribute name is used" do
      assert receiver.some_attr == session
    end
  end

  context "Type is specified" do
    receiver = OpenStruct.new

    type = Controls::SessionType.example

    session = EventStore::HTTP::Session.configure receiver, type: type

    test "Specified type is used" do
      assert session.instance_of?(Controls::SessionType.session_class)
    end
  end

  context "Session is specified" do
    receiver = OpenStruct.new

    session = :some_session

    EventStore::HTTP::Session.configure receiver, session: session

    test "Specified session is used" do
      assert receiver.session.equal?(session)
    end
  end

  context "Settings are specified" do
    receiver = OpenStruct.new

    host = Controls::Hostname::Other.example
    settings = Settings.build({ :host => host })

    session = EventStore::HTTP::Session.configure receiver, settings

    test "Settings are applied to session" do
      assert session.net_http.address == host
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

    session = EventStore::HTTP::Session.configure receiver, settings, namespace: :some_namespace

    test "Settings namespace is applied" do
      assert session.net_http.address == host
    end
  end
end
