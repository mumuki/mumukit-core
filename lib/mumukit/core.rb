require 'mumukit/core/version'
require 'active_support/all'

module Mumukit
  module Core
    class << self
      def test_mode!
        Class.class_eval do
          break if method_defined? :__mumukit_core_contract_new__
          alias_method :__mumukit_core_contract_new__, :new

          def new(*args, &block)
            validate_complies_with_contract!
            __mumukit_core_contract_new__(*args, &block)
          end
        end
      end
    end
  end
end

Mumukit::Core.test_mode! if %w(RACK_ENV RAILS_ENV).any? { |it| ENV[it] == 'test' }

require_relative './core/status'
require_relative './core/object'
require_relative './core/module'
require_relative './core/class'
require_relative './core/json'
require_relative './core/hash'
require_relative './core/string'
require_relative './core/nil'
require_relative './core/array'
require_relative './core/regexp'
require_relative './core/request'
require_relative './core/configurable'
require_relative './core/modulability'
require_relative './core/variability'
require_relative './core/likeability'
require_relative './core/file'
require_relative './core/i18n'
require_relative './core/yaml'
