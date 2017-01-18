require_relative './interactive_init'

session = InteractiveTests::Session.get

stream = InteractiveTests::ReadStream.get

batch_size = InteractiveTests::Batch.size

module OptimizedOutputSchema
  Event = Struct.new :data, :position

  module Transformer
    def self.json
      self
    end

    def self.instance(raw_data)
      raw_data.fetch('entries').map do |entry|
        position = entry.fetch 'eventNumber'
        data_text = entry.fetch 'data'

        data = EventStore::HTTP::JSON::Deserialize.(data_text)

        Event.new data, position
      end
    end

    def self.read(text)
      JSON.parse text
    end
  end
end

read_stream = EventStore::HTTP::ReadStream.build session: session
read_stream.embed_body
read_stream.output_schema = OptimizedOutputSchema

read_event = EventStore::HTTP::ReadEvent.build session: session

events_read = 0

InteractiveTests::Benchmark.start { events_read }

loop do
  events = read_stream.(stream, batch_size: batch_size)

  events.reverse_each.with_index do |event, position|
    events_read += 1

    control_data = Controls::Event::Data.example position

    unless event.position == position
      warn <<~TEXT
        Position mismatch at #{control_position}

          Expected: #{control_position}
          Actual:   #{event.position}

      TEXT
      exit 1
    end

    unless event.data == control_data
      warn <<~TEXT
        Data mismatch at position #{control_position}

          Expected: #{control_data.inspect}
          Actual:   #{event.data.inspect}

      TEXT
      exit 1
    end
  end
end
