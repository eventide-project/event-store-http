require_relative '../../automated_init'

context "Establishing Connection" do
  host = Controls::Hostname::Available.example

  connect = EventStore::HTTP::Connect.build
  connection = connect.raw host

  test "Address of connection is set to host" do
    assert connection.address == host
  end

  context "Connection is established" do
    connection.start

    test "Connection is active" do
      assert connection.active?
    end

    connection.finish
  end
end
