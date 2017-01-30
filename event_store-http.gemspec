# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'evt-event_store-http'
  s.version = '0.1.0.2'
  s.summary = "Client library for EventStore's HTTP interface"
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/event-store-http'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.3.3'

  s.add_runtime_dependency 'evt-configure'
  s.add_runtime_dependency 'evt-identifier-uuid'
  s.add_runtime_dependency 'evt-schema'
  s.add_runtime_dependency 'evt-settings'
  s.add_runtime_dependency 'evt-transform'

  s.add_development_dependency 'test_bench'
  s.add_development_dependency 'ruby-prof-flamegraph'
end
