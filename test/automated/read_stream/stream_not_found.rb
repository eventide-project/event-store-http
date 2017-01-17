require_relative '../automated_init'

context "Read Stream When Stream Not Found" do
  stream = Controls::Stream.example

  read_stream = EventStore::HTTP::ReadStream.build

  test "Stream not found error is raised" do
    assert proc { read_stream.(stream) } do
      raises_error? EventStore::HTTP::ReadStream::StreamNotFoundError
    end
  end
end
