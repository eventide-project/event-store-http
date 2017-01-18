require_relative '../automated_init'

context "Gossip Endpoint Response Deserialization" do
  json_text = Controls::Gossip::Response::JSON.text unavailable: true

  response = Transform::Read.(
    json_text,
    :json,
    EventStore::HTTP::Gossip::Response
  )

  context "Leader member" do
    test "Is nil" do
      assert response.leader.nil?
    end
  end

  context "Unknown state members" do
    test "Includes member in unknown state" do
      assert response.unknown.count == 1

      assert response.unknown[0].external_http_ip == Controls::IPAddress::Cluster.example
    end
  end
end
