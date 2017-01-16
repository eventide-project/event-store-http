require_relative '../automated_init'

context "Write Build Method" do
  context "Session is specified" do
    session = EventStore::HTTP::Session.build

    write = EventStore::HTTP::Write.build session: session

    test "Retry is set to that of session" do
      assert write.retry.equal?(session.retry)
    end
  end

  context "Session is not specified" do
    write = EventStore::HTTP::Write.build

    test "Retry is configured" do
      assert write.retry.instance_of?(EventStore::HTTP::Retry)
    end
  end
end
