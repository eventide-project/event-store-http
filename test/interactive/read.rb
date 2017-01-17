require_relative './interactive_init'

session = InteractiveTests::Session.get

depth = InteractiveTests::Stream.depth
batch_size = 20
batch_count = depth / batch_size

stream = ENV['STREAM']

if stream.nil?
  stream = Controls::Stream.example

  batch_count.times do
    Controls::Write.(events: batch_size, stream: stream, session: session)
  end
end

read_stream = EventStore::HTTP::ReadStream.build session: session
read_event = EventStore::HTTP::ReadEvent.build session: session

events_read = 0

InteractiveTests::Benchmark.start { events_read }

loop do
  batch_count.times do |batch_index|
    batch_position = batch_index * batch_size

    atom_page = read_stream.(stream, position: batch_position, batch_size: batch_size)

    atom_page.entries.reverse_each.with_index do |event, offset|
      event_uri = event.links.fetch :edit

      event = read_event.(event_uri)

      control_position = batch_position + offset
      control_data = Controls::Event::Data.example offset

      event_data = event.content.data
      event_position = event.content.event_number

      unless event_position == control_position
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
    end

    events_read += atom_page.entries.count
  end
end
