require_relative '../automated_init'

context "JSON Serialization" do
  raw_data = EventStore::HTTP::Controls::JSON.data

  text = EventStore::HTTP::JSON::Serialize.(raw_data, pretty_generate: true)

  test "JSON keys are converted to camel casing" do
    assert text == EventStore::HTTP::Controls::JSON.text
  end
end
