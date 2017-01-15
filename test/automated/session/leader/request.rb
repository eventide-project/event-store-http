require_relative '../../automated_init'

context "Leader-Type Session Performs HTTP Request" do
  leader_ip_address, follower_ip_address, * = Controls::Cluster::CurrentMembers.get

  session = EventStore::HTTP::Session.build type: :leader
  session.net_http = Controls::NetHTTP.example host: follower_ip_address

  request = Controls::NetHTTP::Request::Post.example

  response = session.request request

  test "ES-RequireMaster header is set on request" do
    assert request['es-requiremaster'] == 'True'
  end

  test "Successful response is returned (redirect is followed)" do
    assert Net::HTTPSuccess === response
  end

  test "Connection is established with cluster leader" do
    assert session.net_http.ip_address == leader_ip_address
  end
end
