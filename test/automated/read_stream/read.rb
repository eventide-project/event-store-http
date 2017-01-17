require_relative '../automated_init'

context "Read Stream" do
  stream, _ = Controls::Write.(events: 11)

  read_stream = EventStore::HTTP::ReadStream.build

  page = read_stream.(stream)

  test "Page is returned" do
    assert page.instance_of?(EventStore::HTTP::MediaTypes::Atom::Page)
  end

  test "Page includes events" do
    assert page.entries.count == 11
  end
end
