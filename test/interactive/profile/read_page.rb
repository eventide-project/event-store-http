require_relative './profile_init'

session = InteractiveTests::Session.get

stream = Profile::ReadStream.get session

read_stream = EventStore::HTTP::ReadStream.build session: session

Profile.measure do
  read_stream.(stream, batch_size: Profile::Batch.size)
end
