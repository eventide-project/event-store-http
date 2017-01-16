require_relative '../../automated_init'

context "Write, EventStore Responds With Write Timeout Error" do
  context "Retry limit is not exceeded" do
    control_location = Controls::URI::Event.example

    write = EventStore::HTTP::Write.new
    write.connection.set_response 400, reason_phrase: 'Write timeout'
    write.connection.set_response 201, headers: { 'Location' => control_location }

    batch = Controls::MediaTypes::Events.example

    stream = Controls::Stream.example

    location = write.(batch, stream)

    test "Write is successful" do
      assert location == control_location
    end

    test "Request is retried" do
      assert write.retry.telemetry_sink do
        recorded_retried?
      end
    end
  end
end
