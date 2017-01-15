require_relative '../automated_init'

context "Connection Is Terminated During Request Made By Session" do
  request = Controls::NetHTTP::Request.example

  session = EventStore::HTTP::Session.build

  _retry = SubstAttr::Substitute.(:retry, session)
  _retry.set_error Errno::ECONNRESET

  response = session.request request

  test "New connection is established" do
    refute session.connection.equal?(connection)
  end

  test "Request is retried" do
    assert _retry.telemetry_sink do
      recorded_retried?
    end
  end

  test "Response is returned" do
    assert Net::HTTPResponse === response
  end
end
