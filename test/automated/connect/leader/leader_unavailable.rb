require_relative '../../automated_init'

context "Leader Connection Type" do
  context "Leader is currently unavailable" do
    connect = EventStore::HTTP::Connect::Leader.build

    net_http = SubstAttr::Substitute.build Net::HTTP

    info_response = Controls::Info::Response::JSON.text state: :unknown
    net_http.set_response 200, body: info_response

    gossip_response = Controls::Gossip::Response::JSON.text unavailable: true
    net_http.set_response 200, body: gossip_response

    context "Connection is initialized" do
      test "Leader unavailable error is raised" do
        assert proc { connect.connect net_http } do
          raises_error? EventStore::HTTP::Connect::Leader::LeaderUnavailableError
        end
      end
    end
  end
end
