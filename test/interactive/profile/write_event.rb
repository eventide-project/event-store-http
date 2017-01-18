require_relative './profile_init'

session = InteractiveTests::Session.get

write = EventStore::HTTP::Write.build session: session

batch = Controls::MediaTypes::Events.example

Profile.measure do
  stream = Controls::Stream.example

  write.(batch, stream)
end
