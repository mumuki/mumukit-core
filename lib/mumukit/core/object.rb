class Object
  def ensure_present!(*args)
    raise 'arguments must be non null' if args.any?(&:blank?)
  end

  def to_stringified_h
    to_h.stringify_keys
  end

  def defaulting(value)
    if block_given? && !nil?
      result = yield self
    else
      result = self
    end
    result || value
  end

  def struct(hash = {})
    hash.to_struct
  end

  def like?(other)
    to_s == other.to_s
  end
end

class Module
  def like?(other)
    super || to_s.underscore == other.to_s
  end
end
