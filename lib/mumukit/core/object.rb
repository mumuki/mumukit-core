class Object
  def ensure_present!(*args)
    raise 'arguments must be non null' if args.any?(&:blank?)
  end

  def to_stringified_h
    to_h.stringify_keys
  end

  def defaulting(value, &block)
    try(&block) || value
  end

  def struct(hash = {})
    hash.to_struct
  end
end