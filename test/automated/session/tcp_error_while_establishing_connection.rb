require_relative '../automated_init'

context "TCP Error Occurs While Session Esablishes Connection" do
  session = EventStore::HTTP::Session.build

  _retry = SubstAttr::Substitute.(:retry, session)
  _retry.set_error Errno::ECONNRESET

  session.establish_connection

  test "Connection is established" do
    assert session.connection.instance_of?(Net::HTTP)
  end

  test "Request is retried" do
    assert _retry.telemetry_sink do
      recorded_retried?
    end
  end
end
