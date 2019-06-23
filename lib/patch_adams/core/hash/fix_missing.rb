class Hash
  def fix_missing(other)
    other.merge(self)
  end
end
