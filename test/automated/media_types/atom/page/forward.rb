require_relative '../../../automated_init'

context "Atom Media Type, Deserializing Page" do
  json_text = Controls::MediaTypes::Atom::Page::JSON.example

  atom_page = Transform::Read.(json_text, :json, EventStore::HTTP::MediaTypes::Atom::Page)

  test "ID" do
    assert atom_page.id == Controls::MediaTypes::Atom::Page.id
  end

  test "Updated" do
    assert atom_page.updated == Controls::MediaTypes::Atom::Page.updated
  end

  test "Stream ID" do
    assert atom_page.stream_id == Controls::MediaTypes::Atom::Page.stream_id
  end

  test "Self link" do
    assert atom_page.links[:self] == Controls::MediaTypes::Atom::Page::Links.self
  end

  test "First link" do
    assert atom_page.links[:first] == Controls::MediaTypes::Atom::Page::Links.first
  end

  test "Last link" do
    assert atom_page.links[:last] == Controls::MediaTypes::Atom::Page::Links.last
  end

  test "Next link" do
    assert atom_page.links[:next] == Controls::MediaTypes::Atom::Page::Links.next
  end

  test "Previous link" do
    assert atom_page.links[:previous] == Controls::MediaTypes::Atom::Page::Links.previous
  end

  test "Metadata link" do
    assert atom_page.links[:metadata] == Controls::MediaTypes::Atom::Page::Links.metadata
  end

  test "Number of entries" do
    assert atom_page.entries.count == Controls::MediaTypes::Atom::Page::Entries.count
  end

  test "Control" do
    control_page = Controls::MediaTypes::Atom::Page.example

    assert atom_page == control_page
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
