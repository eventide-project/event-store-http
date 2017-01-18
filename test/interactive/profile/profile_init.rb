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

  Batch = InteractiveTests::Batch

  ReadStream = InteractiveTests::ReadStream
end
