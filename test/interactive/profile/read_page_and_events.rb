require_relative './profile_init'

session = InteractiveTests::Session.get

stream = Profile::ReadStream.get

read_stream = EventStore::HTTP::ReadStream.build session: session

read_event = EventStore::HTTP::ReadEvent.build session: session

Profile.measure batch: true do |batch_size|
  atom_page = read_stream.(stream, batch_size: batch_size)

  atom_page.entries.each do |event|
    event_uri = event.links.fetch :edit

    read_event.(event_uri)
  end
end
