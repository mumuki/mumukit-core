class String
  def as_module
    camelcase.constantize
  end
end

class Symbol
  def as_module
    to_s.as_module
  end
end

class Module
  def as_module
    self
  end
end
