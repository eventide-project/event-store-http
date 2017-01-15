require_relative '../automated_init'

context "Connection Is Terminated During Request Made By Session" do
  connection = SubstAttr::Substitute.build Net::HTTP
  connection.set_error Errno::ECONNRESET

  session = EventStore::HTTP::Session.build
  session.connection = connection

  _retry = SubstAttr::Substitute.(:retry, session)

  request = Controls::NetHTTP::Request.example

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
