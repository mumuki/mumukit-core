class Module
  def required(name, message=nil)
    message ||= "You need to implement method #{name}"
    define_method name do |*|
      raise message
    end
  end

  # Redefines a previous definition of the given method.
  # It takes a block with the original arguments and the `hyper`
  # reference to the original definition
  def patch(selector, &block)
    revamp selector do |_, this, *args, hyper|
      this.instance_exec(*args, hyper, &block)
    end
  end

  # `revamp` is a `patch` generalization
  # that accepts multiple selectors and
  # takes a more general callback, like the following:
  #
  # ```
  # revamp :foo, :bar do |selector, this, *args, hyper|
  #   puts "sending #{selector} to #{this}..."
  #   result = hyper.call(*args)
  #   puts "done. result is #{result}"
  #   result
  # end
  # ```
  #
  # `revamp` should be prefered to `patch` when more control or performance
  # is required
  def revamp(*selectors, selector_transformer: nil, &block)
    selectors.each do |selector|
      method_proc = instance_method selector
      selector_transfom = selector_transformer ? selector_transformer.call(selector) : selector

      define_method selector do |*args|
        block.call(selector_transfom, self, *args, method_proc.bind(self))
      end
    end
  end

  # Revamps an accessor. This method is similar to `revamp`,
  # but:
  #
  #  * assumes a 0 arguments array
  #  * takes the accessor's original result instead of the `hyper` reference
  #
  # As a consecuence, `revamp_accessor` can not alter the way and the moment
  # the original method is evaluated.
  #
  # ```
  # revamp_accessor :foo, :bar do |selector, this, result|
  #   puts "result of sending #{selector} to #{this} is #{result}"
  #   result
  # end
  # ```
  #
  # :warning: the block will not be called on a `nil` result
  def revamp_accessor(*selectors, &block)
    revamp(*selectors) do |selector, this, hyper|
      result = hyper.call
      result && block.call(selector, this, result)
    end
  end

  # Caches an accessor, using the idiom `@__foo__ ||= foo`. For example, the following code:
  #
  # ```
  # def foo
  #   @__foo__ ||= #...implementation...
  # end
  # ```
  #
  # Can be turned into:
  #
  # ```
  # def foo
  #   #...implementation...
  # end
  #
  # cache_accessor :foo
  # ```
  #
  def cache_accessor(*selectors)
    revamp(*selectors, selector_transformer: proc { |it| "@__#{it}__".to_sym }) do |attr_name, this, hyper|
      this.instance_variable_get(attr_name) || this.instance_variable_set(attr_name, hyper.call)
    end
  end

  def rewrite(selector, &block)
    raise "method #{selector} was not previously defined here" unless instance_methods(false).include?(selector)
    define_method selector, &block
  end
end
