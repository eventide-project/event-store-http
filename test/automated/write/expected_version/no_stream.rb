require_relative '../../automated_init'

context "WriteEvents Posts Event Batch With Expected Version" do
  batch = Controls::MediaTypes::Events.example random: true

  expected_version = -1

  context "Expected version is -1 (stream does not exist)" do
    context "Stream does not yet exist" do
      stream = Controls::Stream.example

      location = EventStore::HTTP::Write.(batch, stream, expected_version: expected_version)

      test "Batch is written starting at position 0" do
        assert location.path == "/streams/#{stream}/0"
      end
    end

    context "Stream already exists" do
      stream, previous_batch = Controls::Write.(events: 11)

      context "Batch has previously been written at position 0" do
        location = EventStore::HTTP::Write.(previous_batch, stream, expected_version: expected_version)

        test "Location of beginning of stream is returned" do
          assert location.path == "/streams/#{stream}/0"
        end
      end

      context "Batch has not previously been written" do
        test "Expected version error is raised" do
          assert proc { EventStore::HTTP::Write.(batch, stream, expected_version: expected_version) } do
            raises_error? EventStore::HTTP::Write::ExpectedVersionError
          end
        end
      end
    end
  end
end
