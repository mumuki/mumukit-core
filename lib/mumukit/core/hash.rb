class Hash
  def dig(key, *keys)
    value = self[key]
    if !value.nil? && !keys.empty?
      value.dig(*keys)
    else
      value
    end
  end

  def to_struct
    OpenStruct.new self
  end

  def amend(other)
    other.merge(self)
  end
end
