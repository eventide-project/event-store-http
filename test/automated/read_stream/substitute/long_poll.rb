require_relative '../../automated_init'

context "Read Stream Substitute, Long Polling" do
  context do
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

  context "Long poll duration is set to specific duration" do
    substitute = SubstAttr::Substitute.build EventStore::HTTP::ReadStream

    substitute.enable_long_poll 11

    context "Predicate is passed specified duration" do
      test "True is returned" do
        assert substitute.long_poll_enabled?(11)
      end
    end

    context "Predicate is passed different duration" do
      test "False is returned" do
        refute substitute.long_poll_enabled?(22)
      end
    end
  end
end
