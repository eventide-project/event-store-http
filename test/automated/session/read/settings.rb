require_relative '../../automated_init'

context "Session With Read-Specific Settings" do
  host = Controls::Hostname.example

  context "Setting is specified in both namespaces" do
    settings = Settings.build({
      :host => Controls::Hostname::Other.example,
      :read => { :host => host }
    })

    session = EventStore::HTTP::Session::Read.get settings

    test "Setting in read namespace is used" do
      assert session.net_http.address == host
    end
  end
end
