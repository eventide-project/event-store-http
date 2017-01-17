require_relative '../../automated_init'

context "Read Stream Substitute, Long Polling" do
  substitute = SubstAttr::Substitute.build EventStore::HTTP::ReadStream

  context "Long polling has not been enabled" do
    test "Predicate returns false" do
      refute substitute.long_poll_enabled?
    end
  end

  substitute.enable_long_poll

  context "Long polling has been enabled" do
    test "Predicate returns true" do
      assert substitute.long_poll_enabled?
    end
  end
end
