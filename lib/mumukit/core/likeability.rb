class Object
  def like?(other)
    to_s == other.to_s
  end
end

class Module
  def like?(other)
    super || to_s.underscore == other.to_s
  end
end
