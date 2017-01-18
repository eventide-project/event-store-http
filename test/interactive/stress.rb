require_relative './interactive_init'

thread_count = (ENV['THREAD_COUNT'] || '4').to_i

thread_count, remainder = thread_count.divmod 2

read_threads = thread_count + remainder

write_threads = thread_count.times.map do
  Thread.new do
    session = InteractiveTests::Session.get

    stream = Controls::Stream.example
    batch = Controls::MediaTypes::Events.example batch_size: 1

    write = EventStore::HTTP::Write.build session: session

    position = -1

    Thread.current[:operations] = 0

    Thread.stop

    loop do
      write.(batch, stream, expected_version: position)
      position += 1
      Thread.current[:operations] += 1
    end
  end
end

read_threads = (thread_count + remainder).times.map do
  Thread.new do
    session = InteractiveTests::Session.get

    stream = InteractiveTests::ReadStream.get session

    batch_size = InteractiveTests::Batch.size

    read_stream = EventStore::HTTP::ReadStream.build session: session
    read_stream.embed_body
    read_stream.output_schema = Controls::ReadStream::OutputSchema::Optimized.example

    Thread.current[:operations] = 0

    Thread.stop

    loop do
      read_stream.(stream, batch_size: batch_size)

      Thread.current[:operations] += batch_size
    end
  end
end

threads = read_threads + write_threads

InteractiveTests::Benchmark.start do
  threads.reduce 0 do |sum, thread|
    sum + thread[:operations]
  end
end

sleep 0.250

Thread.pass until threads.all? { |thr| thr.status == 'sleep' }

threads.each &:wakeup

loop do
  threads.each do |thread|
    thread.join 0
  end

  sleep 0.250
end
