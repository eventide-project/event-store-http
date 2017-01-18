require_relative '../test_init'

module InteractiveTests
  module ReadStream
    def self.get(session=nil)
      stream = ENV['STREAM']

      if stream.nil?
        batch_size = Batch.size

        stream = Controls::Stream.example

        Controls::Write.(
          events: batch_size,
          stream: stream,
          session: session,
          metadata: true
        )
      end

      stream
    end
  end

  module Batch
    def self.size
      batch_size = ENV['BATCH_SIZE']

      return batch_size.to_i if batch_size

      20
    end
  end

  module Benchmark
    def self.start(&block)
      t0 = Clock.now

      Signal.trap 'INT' do
        exit 0
      end

      at_exit {
        t1 = Clock.now

        elapsed_time = t1 - t0
        operations = block.()
        throughput = Rational(operations, elapsed_time)

        puts <<~TEXT % [operations, elapsed_time, throughput]

        Performance summary
        = = =

        Operations: %i, ElapsedTime: %.3fs, Throughput: %.2f ops/sec

        TEXT
      }
    end
  end

  module Session
    def self.get(host: nil)
      if host.nil?
        if ENV['CLUSTER'] == 'on'
          return Cluster.get
        else
          return NonCluster.get
        end
      end

      settings = EventStore::HTTP::Settings.build
      settings.override({ :host => host })

      session = EventStore::HTTP::Session.build settings
      session.establish_connection
      session
    end

    module NonCluster
      def self.get
        Session.get host: '127.0.0.1'
      end
    end

    module Cluster
      def self.get
        Session.get host: 'eventstore-cluster.local'
      end
    end
  end
end
