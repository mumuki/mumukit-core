class String
  def as_variable_name
    underscore
  end
end

class Symbol
  def as_variable_name
    to_s.underscore
  end
end

class Module
  def as_variable_name
    name.as_variable_name
  end
end
