require_relative '../../automated_init'

context "Establishing Connection, IP Address Is Specified" do
  ip_address = Controls::IPAddress.example

  connect = EventStore::HTTP::Connect.new

  connection = connect.(ip_address)

  test "IP address is used as endpoint address" do
    assert connection.address == ip_address
  end
end
