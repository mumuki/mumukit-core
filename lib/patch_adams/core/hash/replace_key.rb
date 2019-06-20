class Hash
  def replace_key(original, replacement)
    dup.replace_key! original, replacement
  end

  def replace_key!(original, replacement)
    self[replacement] = delete(original) if include?(original)
    self
  end
end
