require_relative '../../automated_init'

context "Any Type Connect" do
  host = Controls::Hostname.example

  connect = EventStore::HTTP::Connect::Any.new
  connect.host = host

  context "Connection is initialized" do
    connection = connect.()

    test "Net::HTTP connection is returned" do
      assert connection.instance_of?(Net::HTTP)
    end

    test "Host setting is used as endpoint address" do
      assert connection.address == host
    end

    test "Connection is not yet active" do
      refute connection.active?
    end
  end
end
