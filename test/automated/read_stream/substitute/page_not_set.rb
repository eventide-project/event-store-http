require_relative '../../automated_init'

context "Read Stream Substitute, No Atom Page Is Set" do
  substitute = SubstAttr::Substitute.build EventStore::HTTP::ReadStream

  stream = Controls::Stream.example

  test "StreamNotFound error is raised" do
    assert proc { substitute.(stream) } do
      raises_error? EventStore::HTTP::ReadStream::StreamNotFoundError
    end
  end
end
