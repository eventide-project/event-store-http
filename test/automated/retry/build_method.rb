require_relative '../automated_init'

context "Retry, Build Method" do
  context "Settings are specified" do
    settings = Settings.build({ :retry_limit => 11 })

    _retry = EventStore::HTTP::Retry.build settings

    test "Settings are applied to instance" do
      assert _retry.retry_limit == 11
    end
  end

  context "Settings namespace is specified" do
    settings = Settings.build({
      :some_namespace => {
        :retry_limit => 11
      }
    })

    _retry = EventStore::HTTP::Retry.build settings, namespace: :some_namespace

    test "Settings are applied to instance" do
      assert _retry.retry_limit == 11
    end
  end
end
