require_relative '../../automated_init'

context "Leader Connection Type" do
  context "Initial connection is with a follower" do
    host = Controls::Hostname::Cluster::Followers.example

    connect = EventStore::HTTP::Connect::Leader.build
    connect.host = host

    context "Connection is initialized" do
      connection = connect.()

      test "Net::HTTP connection is returned" do
        assert connection.instance_of?(Net::HTTP)
      end

      test "IP address of current leader is used as endpoint address" do
        assert connection.address == Controls::IPAddress::Cluster::Leader.example
      end

      test "Connection is not yet active" do
        refute connection.active?
      end
    end
  end
end
