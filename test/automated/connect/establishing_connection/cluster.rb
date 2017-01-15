require_relative '../../automated_init'

context "Establishing Connection, Cluster" do
  context "EventStore cluster is fully available" do
    host = Controls::Hostname::Cluster::Available.example

    connect = EventStore::HTTP::Connect::Any.build
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

  context "EventStore cluster is partilaly available" do
    host = Controls::Hostname::Cluster::PartiallyAvailable.example

    connect = EventStore::HTTP::Connect::Any.build
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

  context "EventStore cluster is unavailable" do
    host = Controls::Hostname::Cluster::Unavailable.example

    connect = EventStore::HTTP::Connect::Any.build
    connection = connect.raw host

    test "Address of connection is set to host" do
      assert connection.address == host
    end

    context "Connection is established" do
      test "Connection refused error is raised" do
        assert proc { connection.start } do
          raises_error? Errno::ECONNREFUSED
        end
      end
    end
  end
end
