require_relative '../automated_init'

context "Write, EventStore Responds With Client Error (4xx)" do
  write = EventStore::HTTP::Write.new
  write.connection.set_response 400

  batch = Controls::MediaTypes::Events.example

  stream = Controls::Stream.example

  test "Request error is raised" do
    assert proc { write.(batch, stream) } do
      raises_error? EventStore::HTTP::Write::Error
    end
  end
end
