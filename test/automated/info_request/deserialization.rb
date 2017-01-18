require_relative '../automated_init'

context "Get Info Endpoint Deserialization" do
  json_text = Controls::Info::Response::JSON.text

  response = Transform::Read.(json_text, :json, EventStore::HTTP::Info::Response)

  test "Cluster state is set" do
    assert response.state == Controls::Info::Response.state
  end

  test "EventStore version is set" do
    assert response.event_store_version == Controls::Info::Response.event_store_version
  end

  test "Projections mode is set" do
    assert response.projections_mode == Controls::Info::Response.projections_mode
  end
end
