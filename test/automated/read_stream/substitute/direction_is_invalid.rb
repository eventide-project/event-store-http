require_relative '../../automated_init'

context "Read Stream Substitute, Direction Is Invalid" do
  substitute = SubstAttr::Substitute.build EventStore::HTTP::ReadStream

  stream = Controls::Stream.example

  test "Argument error is raised" do
    assert proc { substitute.(stream, direction: :unknown) } do
      raises_error? ArgumentError
    end
  end
end
