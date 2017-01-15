require_relative '../../automated_init'

context "Leader Connection Type" do
  context "Initial connection is with leader" do
    host = Controls::Hostname::Cluster::Leader.example

    connect = EventStore::HTTP::Connect::Leader.build
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
end
