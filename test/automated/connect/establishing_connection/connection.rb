require_relative '../../automated_init'

context "Establishing Connection" do
  host = Controls::Hostname::Available.example

  connect = EventStore::HTTP::Connect::Any.build
  connection = connect.raw host

  test "Address of connection is set to host" do
    assert connection.address == host
  end

  test "Net::HTTP extensions are applied" do
    assert connection.is_a?(EventStore::HTTP::NetHTTP::Extensions)
  end

  context "Connection is established" do
    connection.start

    test "Connection is active" do
      assert connection.active?
    end

    connection.finish
  end
end
