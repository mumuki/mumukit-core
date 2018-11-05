require 'set'

class Hash
  unless instance_methods.include?(:dig)
    def dig(key, *keys)
      value = self[key]
      if !value.nil? && !keys.empty?
        value.dig(*keys)
      else
        value
      end
    end
  end

  def to_struct
    OpenStruct.new self
  end

  def amend(other)
    other.merge(self)
  end

  def diff(other)
    s1 = Set.new(self)
    s2 = Set.new(other)
    { deletions: (s1 - s2).to_h, additions: (s2 - s1).to_h }
  end
end
