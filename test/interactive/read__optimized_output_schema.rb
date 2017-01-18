require_relative './interactive_init'

session = InteractiveTests::Session.get

stream = InteractiveTests::ReadStream.get session

batch_size = InteractiveTests::Batch.size

read_stream = EventStore::HTTP::ReadStream.build session: session
read_stream.embed_body
read_stream.output_schema = Controls::ReadStream::OutputSchema::Optimized

events_read = 0

InteractiveTests::Benchmark.start { events_read }

loop do
  events = read_stream.(stream, batch_size: batch_size)

  events.reverse_each.with_index do |event, position|
    events_read += 1
  end
end
