require_relative '../automated_init'

context "Connection Is Terminated During Request Made By Session" do
  # XXX - this needs to be a proper substitute
  connection = Object.new
  connection.instance_exec do
    define_singleton_method :request do |*|
      raise Errno::ECONNRESET
    end
  end
  # /XXX

  request = Controls::NetHTTP::Request.example

  session = EventStore::HTTP::Session.build
  session.connection = connection

  response = session.request request

  test "New connection is established" do
    refute session.connection.equal?(connection)
  end

  test "Response is returned" do
    assert Net::HTTPResponse === response
  end
end
