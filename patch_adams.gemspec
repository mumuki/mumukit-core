# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'patch_adams/version'

Gem::Specification.new do |spec|
  spec.name          = 'patch_adams'
  spec.version       = PatchAdams::VERSION
  spec.authors       = ['Franco Leonardo Bulgarelli']
  spec.email         = ['franco@mumuki.org']

  spec.summary       = "Ruby monkey patches to increase your code's health and your own happines"
  spec.description   = 'Ruby core extensions'
  spec.homepage      = 'https://github.com/mumuki/patch_adams'
  spec.license       = 'MIT'

  spec.files         = Dir['lib/**/*', 'bin/**/*']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib bin)

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '>= 2'
  spec.add_development_dependency 'codeclimate-test-reporter'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'activemodel', '>= 4.1'

  spec.add_dependency 'activesupport', '>= 4.1'
  spec.add_dependency 'rack', '>= 1.5'
  spec.add_dependency 'i18n', '~> 0.7'
end