ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= '_min'

puts RUBY_DESCRIPTION

require_relative '../init.rb'
require 'event_store/http/controls'

require 'test_bench'; TestBench.activate

require 'pp'

Controls = EventStore::HTTP::Controls

Controls::Hostname::Resolution.activate
