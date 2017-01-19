require_relative '../automated_init'

context "Write Posts Event Batch" do
  batch = Controls::MediaTypes::Events.example random: true

  stream = Controls::Stream.example

  context do
    location = EventStore::HTTP::Write.(batch, stream)

    test "Location of first event of batch is returned as URL" do
      assert location == Controls::URI::Event.example(stream: stream)
    end
  end

  context "Batch is written again" do
    location = EventStore::HTTP::Write.(batch, stream)

    test "Location of first event of original batch is returned as URL" do
      assert location == Controls::URI::Event.example(stream: stream)
    end
  end

  context "New batch is written" do
    new_batch = Controls::MediaTypes::Events.example random: true

    location = EventStore::HTTP::Write.(new_batch, stream)

    test "Location of first event of new batch is returned as URL" do
      position = batch.events.count

      assert location == Controls::URI::Event.example(stream: stream, position: position)
    end
  end
end
