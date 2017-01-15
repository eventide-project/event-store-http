require_relative '../../automated_init'

context "Establishing Connection" do
  host = Controls::Hostname::Available.example

  connect = EventStore::HTTP::Connect.new
  connect.host = host

  connection = connect.()

  test "Net::HTTP connection is returned" do
    assert connection.instance_of?(Net::HTTP)
  end

  test "Host setting is used as endpoint address" do
    assert connection.address == host
  end

  test "Net::HTTP extensions are applied" do
    assert connection.is_a?(EventStore::HTTP::NetHTTP::Extensions)
  end

  test "Connection is not yet active" do
    refute connection.active?
  end

  context "Connection is established" do
    connection.start

    test "Connection is active" do
      assert connection.active?
    end

    connection.finish
  end
end
