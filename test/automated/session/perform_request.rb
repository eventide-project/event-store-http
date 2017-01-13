require_relative '../automated_init'

context "Session Performs HTTP Request" do
  session = EventStore::HTTP::Session.new
  session.connect = EventStore::HTTP::Connect.build

  response = session.yield do |connection|
    request = Controls::Request.example

    connection.request request
  end

  test "Response is returned" do
    assert Net::HTTPResponse === response
  end
end
