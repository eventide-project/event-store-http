require_relative '../automated_init'

context "Get Cluster Status From Gossip Endpoint" do
  leader_ip_address, * = Controls::Cluster::CurrentMembers.get

  connection = Controls::NetHTTP.example host: leader_ip_address
  get = EventStore::HTTP::Requests::Gossip::Get.build connection: connection

  response = get.()

  context "Leader external TCP IP address" do
    test "Value is set to that of current cluster leader" do
      assert response.leader.external_tcp_ip == leader_ip_address
    end
  end

  context "Leader external HTTP IP address" do
    test "Value is set to that of current cluster leader" do
      assert response.leader.external_http_ip == leader_ip_address
    end
  end
end
