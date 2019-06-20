module PatchAdams
  module Configurable
    def configure
      yield config
    end

    def reconfigure(&block)
      @config = nil
      configure(&block)
    end

    def config
      @config ||= defaults.dup
    end

    def defaults
      {}
    end
  end
end
