require_relative '../automated_init'

context "IOError Raised During Request Made By Session" do
  net_http = SubstAttr::Substitute.build Net::HTTP
  net_http.set_error IOError

  session = EventStore::HTTP::Session.build
  session.net_http = net_http

  _retry = SubstAttr::Substitute.(:retry, session)

  request = Controls::NetHTTP::Request.example

  response = session.request request

  test "Session reconnects" do
    refute session.net_http.equal?(net_http)
  end

  test "Request is retried" do
    assert _retry.telemetry_sink do
      recorded_retried? do |record|
        record.data.error.instance_of? IOError
      end
    end
  end

  test "Response is returned" do
    assert Net::HTTPResponse === response
  end
end
