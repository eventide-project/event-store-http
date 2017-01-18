require_relative './interactive_init'

session = InteractiveTests::Session.get

stream = InteractiveTests::ReadStream.get

batch_size = InteractiveTests::Batch.size

read_stream = EventStore::HTTP::ReadStream.build session: session
read_stream.enable_rich_embed

read_event = EventStore::HTTP::ReadEvent.build session: session

events_read = 0

InteractiveTests::Benchmark.start { events_read }

loop do
  atom_page = read_stream.(stream, batch_size: batch_size)

  atom_page.entries.reverse_each.with_index do |event, position|
    event_uri = event.links.fetch :edit

    event = read_event.(event_uri)

    control_data = Controls::Event::Data.example position

    event_data = event.content.data
    event_position = event.content.event_number

    unless event_position == position
      warn <<~TEXT
        Position mismatch at #{control_position} (#{event_uri})

          Expected: #{control_position}
          Actual:   #{event_position}

      TEXT
      exit 1
    end

    unless event_data == control_data
      warn <<~TEXT
        Data mismatch at position #{control_position} (#{event_uri})

          Expected: #{control_data.inspect}
          Actual:   #{event_data.inspect}

      TEXT
      exit 1
    end

    events_read += 1
  end
end
