require_relative '../automated_init'

context "Get Info Endpoint, EventStore Is Clustered" do
  leader_ip_address, *follower_ip_addresses = Controls::Cluster::CurrentMembers.get

  context "Query is performed against leader" do
    connection = Controls::NetHTTP.example host: leader_ip_address
    get = EventStore::HTTP::Info.build connection: connection

    response = get.()

    test "Response indicates EventStore node is leader" do
      assert response.leader?
    end

    test "Response indicates EventStore node is not follower" do
      refute response.follower?
    end
  end

  follower_ip_addresses.each_with_index do |follower_ip_address, index|
    context "Query is performed against follower ##{index + 1}" do
      connection = Controls::NetHTTP.example host: follower_ip_address
      get = EventStore::HTTP::Info.build connection: connection

      response = get.()

      test "Response indicates EventStore node is follower" do
        assert response.follower?
      end

      test "Response indicates EventStore node is not leader" do
        refute response.leader?
      end
    end
  end
end
