require_relative './profile_init'

session = InteractiveTests::Session.get

stream = ENV['STREAM']

if stream.nil?
  batch_size = InteractiveTests::Stream.batch_size

  stream = Controls::Stream.example

  Controls::Write.(events: batch_size, stream: stream, session: session)
end

read_stream = EventStore::HTTP::ReadStream.build session: session
read_event = EventStore::HTTP::ReadEvent.build session: session

prof_result = RubyProf.profile do
  atom_page = read_stream.(stream)

  atom_page.entries.each do |event|
    event_uri = event.links.fetch :edit

    read_event.(event_uri)
  end
end

printer = RubyProf::FlameGraphPrinter.new prof_result
printer.print $stdout, Hash.new
