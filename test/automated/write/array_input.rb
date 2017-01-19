require_relative '../automated_init'

context "Write Posts Event Batch Supplied As Array" do
  batch = Controls::MediaTypes::Events.example random: true
  batch = batch.events

  stream = Controls::Stream.example

  location = EventStore::HTTP::Write.(batch, stream)

  test "Batch is written" do
    assert location == Controls::URI::Event.example(stream: stream)
  end
end
