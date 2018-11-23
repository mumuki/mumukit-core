class String
  def as_module
    as_module_name.constantize
  end

  def as_module_name
    camelcase
  end
end

class Symbol
  def as_module
    to_s.as_module
  end

  def as_module_name
    to_s.as_module_name
  end
end

class Module
  def as_module
    self
  end

  def as_module_name
    name
  end
end
