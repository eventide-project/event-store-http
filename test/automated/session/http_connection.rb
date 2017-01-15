require_relative '../automated_init'

context "Session HTTP Connection" do
  session = EventStore::HTTP::Session.build

  context "Initial connection" do
    net_http = session.net_http

    test "Net::HTTP connection is active" do
      assert net_http.active?
    end
  end

  context "Session reconnects" do
    previous_net_http = session.net_http

    net_http = session.reconnect

    test "Previous Net::HTTP connection is no longer active" do
      refute previous_net_http.active?
    end

    test "Next connection is active" do
      assert net_http.active?
    end
  end
end
