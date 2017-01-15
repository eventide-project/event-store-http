require_relative '../../automated_init'

context "Establishing Connection, EventStore Is Unavailable" do
  host = Controls::Hostname::Unavailable.example

  connect = EventStore::HTTP::Connect::Any.build
  connection = connect.raw host

  context "Connection is established" do
    test "Connection refused error is raised" do
      assert proc { connection.start } do
        raises_error? Errno::ECONNREFUSED
      end
    end
  end
end
