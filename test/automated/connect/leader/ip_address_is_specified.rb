require_relative '../../automated_init'

context "Establishing Connection With Leader, IP Address Is Specified" do
  leader_ip_address, follower_ip_address, * = Controls::Cluster::CurrentMembers.get

  connect = EventStore::HTTP::Connect::Leader.build

  context "IP address refers to current cluster leader" do 
    connection = connect.(leader_ip_address)

    test "Connection is established with leader" do
      assert connection.address == leader_ip_address
    end
  end

  context "IP address refers to current cluster follower" do
    connection = connect.(follower_ip_address)

    test "Connection is established with follower (gossip query is not performed)" do
      assert connection.address == follower_ip_address
    end
  end
end
