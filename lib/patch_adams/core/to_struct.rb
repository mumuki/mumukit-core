class Hash
  def to_struct
    OpenStruct.new self
  end
end

class Object
  def struct(hash = {})
    hash.to_struct
  end
end

