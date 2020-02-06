class Module
  def rewrite(selector, &block)
    raise "method #{selector} was not previously defined here" unless method_defined?(selector)
    define_method selector, &block
  end
end