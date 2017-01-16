require_relative '../../automated_init'

context "WriteEvents Posts Event Batch With Expected Version" do
  batch = Controls::MediaTypes::Events.example random: true

  expected_version = 0

  context "Expected version is 0" do
    context "Stream does not yet exist" do
      stream = Controls::Stream.example

      test "Expected version error is raised" do
        assert proc { EventStore::HTTP::Write.(batch, stream, expected_version: expected_version) } do
          raises_error? EventStore::HTTP::Write::ExpectedVersionError
        end
      end
    end

    context "Stream exists and is at version 0" do
      context "Previously written event is written again" do
        stream, previous_batch = Controls::Write.(events: 1)

        location = EventStore::HTTP::Write.(batch, stream, expected_version: expected_version)

        test "Batch is written again starting at position 1" do
          assert location.path == "/streams/#{stream}/1"
        end
      end

      context "New batch is written" do
        stream, previous_batch = Controls::Write.(events: 1)

        location = EventStore::HTTP::Write.(batch, stream, expected_version: expected_version)

        test "Batch is written starting at spceified expected version" do
          assert location.path == "/streams/#{stream}/1"
        end
      end
    end

    context "Stream exists and is ahead of version 0" do
      stream, _ = Controls::Write.(events: 2)

      test "Expected version error is raised" do
        assert proc { EventStore::HTTP::Write.(batch, stream, expected_version: expected_version) } do
          raises_error? EventStore::HTTP::Write::ExpectedVersionError
        end
      end
    end
  end
end
