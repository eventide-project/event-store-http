require_relative '../automated_init'

context "EventStore Response To Request Made By Session With Server Error (5xx)" do
  net_http = SubstAttr::Substitute.build Net::HTTP
  net_http.set_response 500
  net_http.set_response 200

  session = EventStore::HTTP::Session.build
  session.net_http = net_http

  _retry = SubstAttr::Substitute.(:retry, session)

  request = Controls::NetHTTP::Request.example

  response = session.request request

  test "Session does not reconnect" do
    assert session.net_http.equal?(net_http)
  end

  test "Request is retried" do
    assert _retry.telemetry_sink do
      recorded_retried?
    end
  end

  test "Next response is returned" do
    assert Net::HTTPSuccess === response
  end
end
