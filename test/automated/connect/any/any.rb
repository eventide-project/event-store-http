require_relative '../../automated_init'

context "Any Type Connect" do
  host = Controls::Hostname.example

  connect = EventStore::HTTP::Connect::Any.new
  connect.host = host

  context "Connection is initialized" do
    raw_connection = connect.()

    test "Net::HTTP connection is returned" do
      assert raw_connection.instance_of?(Net::HTTP)
    end

    test "Host setting is used as endpoint address" do
      assert raw_connection.address == host
    end

    test "Port setting is used" do
      assert raw_connection.port == Controls::Port.example
    end

    context "Connection is started" do
      raw_connection.start

      test "Connection is active" do
        assert raw_connection.active?
      end
    end
  end
end
