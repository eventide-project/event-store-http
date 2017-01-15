require_relative '../automated_init'

context "EventStore Response To Request Made By Session With Client Error (4xx)" do
  connection = SubstAttr::Substitute.build Net::HTTP
  connection.set_response 400

  session = EventStore::HTTP::Session.build
  session.connection = connection

  _retry = SubstAttr::Substitute.(:retry, session)

  request = Controls::NetHTTP::Request.example

  response = session.request request

  test "New connection is not established" do
    assert session.connection.equal?(connection)
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
