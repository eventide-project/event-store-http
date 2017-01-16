require_relative '../../automated_init'

context "Write Substitute Issues Request, Expected Version" do
  expected_version = 11

  batch = Controls::MediaTypes::Events.example
  stream = Controls::Stream.example

  context "Current version is not set" do
    substitute = SubstAttr::Substitute.build EventStore::HTTP::Write

    location = substitute.(batch, stream, expected_version: expected_version)

    test "Location" do
      control_uri = URI::HTTP.build :path => "/streams/#{stream}/#{expected_version + 1}"

      assert location == control_uri
    end

    context "Written predicate" do
      test "Block is passed expected version" do
        version = nil

        substitute.written? do |_, _, expected_version|
          version = expected_version
        end

        assert version == expected_version
      end
    end
  end

  context "Current version is set" do
    context "Expected version matches current version" do
      substitute = SubstAttr::Substitute.build EventStore::HTTP::Write
      substitute.version = expected_version

      test "Expected version error is not raised" do
        refute proc { substitute.(batch, stream, expected_version: expected_version) } do
          raises_error? EventStore::HTTP::Write::ExpectedVersionError
        end
      end
    end

    context "Expected version is not supplied to actuator" do
      substitute = SubstAttr::Substitute.build EventStore::HTTP::Write
      substitute.version = expected_version

      location = substitute.(batch, stream, expected_version: nil)

      test "Location" do
        control_uri = URI::HTTP.build :path => "/streams/#{stream}/#{expected_version + 1}"

        assert location == control_uri
      end
    end

    context "Expected version does not match current version" do
      substitute = SubstAttr::Substitute.build EventStore::HTTP::Write
      substitute.version = expected_version + 1

      test "Expected version error is raised" do
        assert proc { substitute.(batch, stream, expected_version: expected_version) } do
          raises_error? EventStore::HTTP::Write::ExpectedVersionError
        end
      end
    end
  end
end
