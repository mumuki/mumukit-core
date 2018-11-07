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

  def deep_diff(other)
    diff = diff(other)
    deep_diff = diff.dup
    deep_deletions = deep_diff[:deletions]
    deep_additions = deep_diff[:additions]

    diff[:deletions].each do |k, v|
      added_v = diff[:additions][k]
      next if !diff[:additions].include?(k) || v.class != added_v.class
      if Array === v
        values = v.zip(added_v)
        deep_deletions[k] = []
        deep_additions[k] = []
        values.select { |v1, v2| v1 != v2 }.each do |v1, v2|
          if Hash === v1 && Hash === v2
            sub_diff = v1.deep_diff(v2)
            deep_deletions[k] << sub_diff[:deletions]
            deep_additions[k] << sub_diff[:additions]
          else
            deep_deletions[k] << v1
            deep_additions[k] << v2
          end
        end
      elsif Hash === v
        sub_diff = v.deep_diff(added_v)
        deep_deletions[k] = sub_diff[:deletions]
        deep_additions[k] = sub_diff[:additions]
      end
    end

    deep_diff
  end
end
