require_relative '../automated_init'

context "Session Settings" do
  context "Host" do
    host = Controls::Hostname::Other.example
    settings = Settings.build({ :host => host })

    session = EventStore::HTTP::Session.build settings

    test "Connections are established with specified host" do
      assert session.connection.address == host
    end
  end

  context "Namespace" do
    host = Controls::Hostname::Other.example
    settings = Settings.build({
      :some_namespace => {
        :host => host
      }
    })

    session = EventStore::HTTP::Session.build settings, namespace: :some_namespace

    test "Settings within namespace are used" do
      assert session.connection.address == host
    end
  end
end
