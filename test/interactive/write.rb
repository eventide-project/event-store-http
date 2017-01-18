require_relative './interactive_init'

session = InteractiveTests::Session.get

write = EventStore::HTTP::Write.build session: session

stream = Controls::Stream.example

batch = Controls::MediaTypes::Events.example batch_size: 1

position = -1

InteractiveTests::Benchmark.start { position + 1 }

loop do
  write.(batch, stream, expected_version: position)

  position += 1
end
