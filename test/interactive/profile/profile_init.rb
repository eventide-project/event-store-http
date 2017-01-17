require_relative '../interactive_init'

require 'ruby-prof'
require 'ruby-prof-flamegraph'

module Profile
  def self.measure(&block)
    Iterations::Warmup.get.times &block

    iterations = Iterations.get

    prof_result = RubyProf.profile do
      iterations.times do
        block.()
      end
    end

    printer = RubyProf::FlameGraphPrinter.new prof_result
    printer.print $stdout, Hash.new
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
    def self.get
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
