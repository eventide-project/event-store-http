require_relative './profile_init'

stream = Profile::ReadStream.get

read_event = EventStore::HTTP::ReadEvent.build

json_text = Controls::MediaTypes::Atom::Event::JSON.example

connection = SubstAttr::Substitute.(:connection, read_event)
connection.set_response 200, body: json_text

Profile.measure do
  read_event.(stream: stream, position: 0)
end
