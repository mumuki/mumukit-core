class Module
  def required(name, message=nil)
    message ||= "You need to implement method #{name}"
    define_method name do |*|
      raise message
    end
  end

  def patch(method_name, &block)
    method_proc = instance_method method_name

    define_method method_name do |*args|
      block.call(*args, method_proc.bind(self))
    end
  end
end
