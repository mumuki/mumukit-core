class Object
  def defaulting(value)
    if block_given? && !nil?
      result = yield self
    else
      result = self
    end
    result || value
  end
end
