class NilClass
  def attempt(default_value = nil, &block)
    default_value
  end
end

class Object
  def attempt(default_value = nil)
    raise 'no block given' unless block_given?
    (yield self rescue nil) || default_value
  end
end
