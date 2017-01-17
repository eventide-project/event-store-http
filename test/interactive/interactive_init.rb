require_relative '../test_init'

module InteractiveTests
  module Stream
    def self.depth
      depth = ENV['STREAM_DEPTH']

      return depth.to_i if depth

      2000
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
