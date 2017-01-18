require_relative './profile_init'

session = InteractiveTests::Session.get

stream = Profile::ReadStream.get session

read_stream = EventStore::HTTP::ReadStream.build session: session
read_stream.embed_body
read_stream.output_schema = Controls::ReadStream::OutputSchema::Optimized

Profile.measure do
  read_stream.(stream, batch_size: Profile::Batch.size)
end
