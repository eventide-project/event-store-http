require_relative '../../automated_init'

context "WriteEvents Posts Event Batch With Expected Version" do
  batch = Controls::MediaTypes::Events.example random: true

  expected_version = 11

  context "Stream does not yet exist" do
    stream = Controls::Stream.example

    test "Expected version error is raised" do
      assert proc { EventStore::HTTP::Write.(batch, stream, expected_version: expected_version) } do
        raises_error? EventStore::HTTP::Write::ExpectedVersionError
      end
    end
  end

  context "Stream is behind expected version" do
    comment "Expected version is 11, but if stream contains 11 events then it is at version 10"

    stream, _ = Controls::Write.(events: expected_version)

    test "Expected version error is raised" do
      assert proc { EventStore::HTTP::Write.(batch, stream, expected_version: expected_version) } do
        raises_error? EventStore::HTTP::Write::ExpectedVersionError
      end
    end
  end

  context "Stream is at expected version" do
    context "Previously written batch is written again" do
      stream, previous_batch = Controls::Write.(events: expected_version + 1)

      location = EventStore::HTTP::Write.(previous_batch, stream, expected_version: expected_version)

      test "Batch is written again starting at specified expected version" do
        assert location.path == "/streams/#{stream}/#{expected_version + 1}"
      end
    end

    context "New batch is written" do
      stream, _ = Controls::Write.(events: expected_version + 1)

      location = EventStore::HTTP::Write.(batch, stream, expected_version: expected_version)

      test "Batch is written starting at spceified expected version" do
        assert location.path == "/streams/#{stream}/#{expected_version + 1}"
      end
    end
  end

  context "Stream is ahead of expected version" do
    context "Batch has previously been written at position corresponding to expected version" do
      stream, _ = Controls::Write.(events: expected_version + 1)
      _, previous_batch = Controls::Write.(events: 1)

      location = EventStore::HTTP::Write.(previous_batch, stream, expected_version: expected_version)

      test "Location of beginning of previous batch is returned" do
        assert location.path == "/streams/#{stream}/#{expected_version + 1}"
      end
    end

    context "Batch has previously been written at other position" do
      stream, previous_batch = Controls::Write.(events: expected_version + 2)

      test "Expected version error is raised" do
        assert proc { EventStore::HTTP::Write.(previous_batch, stream, expected_version: expected_version) } do
          raises_error? EventStore::HTTP::Write::ExpectedVersionError
        end
      end
    end

    context "Batch has not previously been written" do
      stream, _ = Controls::Write.(events: expected_version + 2)

      test "Expected version error is raised" do
        assert proc { EventStore::HTTP::Write.(batch, stream, expected_version: expected_version) } do
          raises_error? EventStore::HTTP::Write::ExpectedVersionError
        end
      end
    end
  end
end
