require_relative '../automated_init'

context "Session Settings" do
  context "Settings are specified" do
    host = Controls::Hostname::Other.example
    settings = Settings.build({ :host => host })

    session = EventStore::HTTP::Session.build settings

    test "Settings are used" do
      assert session.net_http.address == host
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
      assert session.net_http.address == host
    end
  end
end
