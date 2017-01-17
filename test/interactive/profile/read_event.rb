require_relative './profile_init'

session = InteractiveTests::Session.get

stream = Profile::ReadStream.get

read_event = EventStore::HTTP::ReadEvent.build session: session

Profile.measure do
  read_event.(stream: stream, position: 0)
end
