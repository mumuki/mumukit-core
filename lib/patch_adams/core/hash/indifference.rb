require 'set'

class Hash
  def indifferent_delete(key)
    string_value = delete(key.to_s)
    delete(key.to_sym) || string_value
  end

  def indifferent_get(key)
    self[key.to_sym] || self[key.to_s]
  end
end
