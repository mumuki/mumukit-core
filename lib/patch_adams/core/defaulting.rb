class NilClass
  def defaulting(default_value)
    default_value
  end
end

class Object
  def defaulting(_default_value)
    self
  end
end
