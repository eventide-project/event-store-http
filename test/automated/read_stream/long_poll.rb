require_relative '../automated_init'

context "Read Stream With Long Poll Enabled" do
  read_stream = EventStore::HTTP::ReadStream.build

  stream = Controls::Stream.example

  connection = SubstAttr::Substitute.(:connection, read_stream)
  connection.set_response 200, body: Controls::MediaTypes::Atom::Page::JSON.text

  read_stream.enable_long_poll

  read_stream.(stream)

  test "Request includes the ES-LongPoll header" do
    duration = EventStore::HTTP::ReadStream::Defaults.long_poll_duration.to_s

    assert connection.telemetry_sink do
      recorded_requested? do |record|
        record.data.request['es-longpoll'] == duration
      end
    end
  end
end
