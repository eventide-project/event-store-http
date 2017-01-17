require_relative '../../automated_init'

context "Read Stream Substitute" do
  substitute = SubstAttr::Substitute.build EventStore::HTTP::ReadStream

  stream = Controls::Stream.example

  control_page = Controls::MediaTypes::Atom::Page.example

  substitute.set_response stream, control_page

  page = substitute.(stream)

  test "Page is returned" do
    assert page == control_page
  end
end
