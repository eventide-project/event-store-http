require_relative '../../automated_init'

context "Write Substitute Issues Request" do
  substitute = SubstAttr::Substitute.build EventStore::HTTP::Write

  batch = Controls::MediaTypes::Events.example
  stream = Controls::Stream.example

  location = substitute.(batch, stream)

  test "Location" do
    control_uri = URI::HTTP.build :path => "/streams/#{stream}/0"

    assert location == control_uri
  end

  context "Written predicate" do
    context "No block is specified" do
      test "True is returned" do
        assert substitute.written?
      end
    end

    context "Block is specified" do
      test "Block is called with each event in batch" do
        events = []

        substitute.written? do |event|
          events << event
        end

        assert events == batch.events
      end

      test "Block is passed stream" do
        _stream = nil

        substitute.written? do |_, stream|
          _stream = stream
        end

        assert _stream == stream
      end

      test "True is returned if block evaluates truthfully" do
        assert substitute.written? do
          true
        end
      end

      test "False is returned if block does not evaluate truthfully" do
        refute substitute.written? do
          false
        end
      end
    end
  end
end
