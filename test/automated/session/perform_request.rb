require_relative '../automated_init'

context "Session Performs HTTP Request" do
  session = EventStore::HTTP::Session.new
  session.connect = EventStore::HTTP::Connect.build

  request = Controls::NetHTTP::Request.example

  response = session.request request

  test "Response is returned" do
    assert Net::HTTPResponse === response
  end
end
