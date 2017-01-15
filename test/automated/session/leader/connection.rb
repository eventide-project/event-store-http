require_relative '../../automated_init'

context "Leader Session Connects To Cluster Leader" do
  leader_ip_address, follower_ip_address, * = Controls::Cluster::CurrentMembers.get

  session = EventStore::HTTP::Session.build type: :leader
  session.connect.host = Controls::Hostname::Cluster.example

  context "Session is currently connected to follower" do
    session.net_http = Controls::NetHTTP.example host: follower_ip_address

    context "Reconnect" do
      session.reconnect

      test "New connection is established with leader" do
        assert session.net_http.ip_address == leader_ip_address
      end
    end
  end
end
