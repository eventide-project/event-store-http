require_relative '../automated_init'

context "EventStore Response To Request Made By Session With Server Error (5xx)" do
  connection = SubstAttr::Substitute.build Net::HTTP
  connection.set_response 500
  connection.set_response 200

  session = EventStore::HTTP::Session.build
  session.connection = connection

  _retry = SubstAttr::Substitute.(:retry, session)

  request = Controls::NetHTTP::Request.example

  response = session.request request

  test "New connection is not established" do
    assert session.connection.equal?(connection)
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
