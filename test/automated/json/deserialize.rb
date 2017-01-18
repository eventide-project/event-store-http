require_relative '../automated_init'

context "JSON Deserialization" do
  text = EventStore::HTTP::Controls::JSON.text

  raw_data = EventStore::HTTP::JSON::Deserialize.(text)

  test "JSON keys are converted to underscore cased symbols" do
    assert raw_data == EventStore::HTTP::Controls::JSON.data
  end
end
