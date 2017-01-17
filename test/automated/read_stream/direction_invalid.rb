require_relative '../automated_init'

context "Read Stream, Direction Is Invalid" do
  stream = Controls::Stream.example

  read_stream = EventStore::HTTP::ReadStream.build

  test "Argument error is raised" do
    assert proc { read_stream.(stream, direction: :unknown) } do
      raises_error? ArgumentError
    end
  end
end
