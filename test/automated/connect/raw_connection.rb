require_relative '../automated_init'

context "Connect Instantiates Raw Connection" do
  ip_address = Controls::IPAddress.example

  connect = EventStore::HTTP::Connect.build

  connection = connect.raw ip_address

  test "Specified IP address is used as endpoint address" do
    assert connection.address == ip_address
  end

  test "Host is not used as endpoint address" do
    refute connection.address == connect.host
  end
end
