require_relative '../interactive_init'

require 'ruby-prof'
require 'ruby-prof-flamegraph'

module Profile
  def self.measure(batch: nil, &block)
    iterations = Iterations.get
    warmup_iterations = Iterations::Warmup.get

    if batch == true
      batch_size = Batch.size

      warmup_iterations /= batch_size
      iterations /= batch_size
    end

    warmup_iterations.times do
      block.(batch_size)
    end

    prof_result = RubyProf.profile do
      iterations.times do
        block.(batch_size)
      end
    end

    printer = RubyProf::FlameGraphPrinter.new prof_result
    printer.print $stdout, Hash.new
  end

  module Batch
    def self.size
      batch_size = ENV['BATCH_SIZE']

      return batch_size.to_i if batch_size

      20
    end
  end

  module Iterations
    def self.get
      iterations = ENV['ITERATIONS']

      return iterations.to_i if iterations

      100
    end

    module Warmup
      def self.get
        iterations = ENV['WARMUP_ITERATIONS']

        return iterations.to_i if iterations

        20
      end
    end
  end

  module ReadStream
    def self.get(session=nil)
      stream = ENV['STREAM']

      if stream.nil?
        batch_size = InteractiveTests::Stream.batch_size

        stream = Controls::Stream.example

        Controls::Write.(events: batch_size, stream: stream, session: session)
      end

      stream
    end
  end
end
