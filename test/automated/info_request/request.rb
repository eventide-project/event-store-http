require_relative '../automated_init'

context "Get Info Endpoint" do
  get = EventStore::HTTP::Info.build

  response = get.()

  context "EventStore is non-clustered" do
    test "Response indicates EventStore node is leader" do
      assert response.leader?
    end
  end

  test "EventStore version is set" do
    version_pattern = %r{\A[[:digit:]]\.[[:digit:]]\.[[:digit:]](?:\.[[:digit:]])?\z}

    assert response.event_store_version.match?(version_pattern)
  end

  test "Projections mode is set" do
    assert response.projections_mode
  end
end
