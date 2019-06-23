class String
  alias_method :captures, :gsub
end

class NilClass
  def captures(*)
    []
  end
end
