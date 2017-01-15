require_relative '../../automated_init'

context "Session Configures Dependency With Read-Specific Session" do
  host = Controls::Hostname.example

  settings = Settings.build({
    :host => Controls::Hostname::Other.example,
    :read => { :host => host }
  })

  context "Attribute name is not specified" do
    receiver = OpenStruct.new

    session = EventStore::HTTP::Session::Read.configure receiver, settings

    test "Default attribute name is used" do
      assert receiver.session == session
    end

    test "Session instance is returned" do
      assert session.is_a?(EventStore::HTTP::Session)
    end

    test "Read specific settings are used" do
      assert session.net_http.address == host
    end
  end

  context "Attribute name is specified" do
    receiver = OpenStruct.new

    session = EventStore::HTTP::Session::Read.configure receiver, attr_name: :some_attr

    test "Default attribute name is used" do
      assert receiver.some_attr == session
    end
  end

  context "Session is supplied" do
    receiver = OpenStruct.new

    session = EventStore::HTTP::Session.build

    EventStore::HTTP::Session::Read.configure receiver, settings, session: session

    test "Supplied session is used" do
      assert receiver.session.equal?(session)
    end
  end
end
