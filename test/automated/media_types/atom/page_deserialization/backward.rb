require_relative '../../../automated_init'

context "Atom Media Type, Deserializing Page Read Backwards" do
  json_text = Controls::MediaTypes::Atom::Page::JSON::Backward.example

  atom_page = Transform::Read.(json_text, :json, EventStore::HTTP::MediaTypes::Atom::Page)

  test "Next link" do
    assert atom_page.links[:next] == Controls::MediaTypes::Atom::Page::Links::Backward.next
  end

  test "Previous link" do
    assert atom_page.links[:previous] == Controls::MediaTypes::Atom::Page::Links::Backward.previous
  end

  test "Number of entries" do
    assert atom_page.entries.count == Controls::MediaTypes::Atom::Page::Entries.count
  end

  atom_page.entries.each_with_index do |entry, position|
    context "Event @#{position}" do
      test "Title" do
        assert entry.title == Controls::MediaTypes::Atom::Page::Entries.title(position)
      end

      test "ID" do
        assert entry.id == Controls::MediaTypes::Atom::Page::Entries.id(position)
      end

      test "Summary" do
        assert entry.summary == Controls::MediaTypes::Atom::Page::Entries.summary
      end

      test "Edit link" do
        assert entry.links[:edit] == Controls::MediaTypes::Atom::Page::Entries::Links.edit(position)
      end

      test "Alternate link" do
        assert entry.links[:alternate] == Controls::MediaTypes::Atom::Page::Entries::Links.alternate(position)
      end
    end
  end
end
