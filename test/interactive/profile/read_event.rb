require_relative './profile_init'

session = InteractiveTests::Session.get

stream = ENV['STREAM']

if stream.nil?
  batch_size = InteractiveTests::Stream.batch_size

  stream = Controls::Stream.example

  Controls::Write.(events: batch_size, stream: stream, session: session)
end

read_event = EventStore::HTTP::ReadEvent.build session: session

prof_result = RubyProf.profile do
  read_event.(stream: stream, position: 0)
end

printer = RubyProf::FlameGraphPrinter.new prof_result
printer.print $stdout, Hash.new
