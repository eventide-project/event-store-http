require_relative '../automated_init'

context "Read Stream, EventStore Responds With Client Error (4xx)" do
  read_stream = EventStore::HTTP::ReadStream.new
  read_stream.connection.set_response 400

  stream = Controls::Stream.example

  test "Request error is raised" do
    assert proc { read_stream.(stream) } do
      raises_error? EventStore::HTTP::ReadStream::Error
    end
  end
end
