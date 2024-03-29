# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mumukit/core/version'

Gem::Specification.new do |spec|
  spec.name          = 'mumukit-core'
  spec.version       = Mumukit::Core::VERSION
  spec.authors       = ['Franco Leonardo Bulgarelli']
  spec.email         = ['franco@mumuki.org']

  spec.summary       = 'Ruby core extensions for mumuki on top of active support'
  spec.description   = 'Ruby core extensions'
  spec.homepage      = 'https://github.com/mumuki/mumukit-core'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*', 'bin/**/*']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib bin)

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 12.3'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'activemodel', '>= 6.0', '< 8'

  spec.add_dependency 'activesupport', '>= 6.0', '< 8'
  spec.add_dependency 'rack', '>= 1.5'
  spec.add_dependency 'i18n', '>= 0.7', '< 2'

  spec.required_ruby_version = '>= 3.0'
end
