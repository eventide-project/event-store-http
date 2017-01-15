require_relative '../../automated_init'

context "Net::HTTP Substitute, Connection Lifecycle" do
  substitute = SubstAttr::Substitute.build Net::HTTP

  context "Connection is not been started" do
    test "False is returned" do
      refute substitute.active?
    end
  end

  context "Session is started" do
    substitute.start

    test "True is returned" do
      assert substitute.active?
    end
  end

  context "Session is finished" do
    substitute.finish

    test "False is returned" do
      refute substitute.active?
    end
  end
end
