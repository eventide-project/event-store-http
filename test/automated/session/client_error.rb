require_relative '../automated_init'

context "EventStore Response To Request Made By Session With Client Error (4xx)" do
  net_http = SubstAttr::Substitute.build Net::HTTP
  net_http.set_response 400

  session = EventStore::HTTP::Session.build
  session.net_http = net_http

  _retry = SubstAttr::Substitute.(:retry, session)

  request = Controls::NetHTTP::Request.example

  response = session.request request

  test "Session does not reconnect" do
    assert session.net_http.equal?(net_http)
  end

  test "Request is not retried" do
    refute _retry.telemetry_sink do
      recorded_retried?
    end
  end

  test "Response is returned" do
    assert Net::HTTPClientError === response
  end
end
