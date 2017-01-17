require_relative '../../automated_init'

context "Read Stream Substitute, Rich Embedding" do
  substitute = SubstAttr::Substitute.build EventStore::HTTP::ReadStream

  context "Rich embedding has not been enabled" do
    test "Predicate returns false" do
      refute substitute.rich_embed_enabled?
    end
  end

  substitute.enable_rich_embed

  context "Rich embedding has been enabled" do
    test "Predicate returns true" do
      assert substitute.rich_embed_enabled?
    end
  end
end
