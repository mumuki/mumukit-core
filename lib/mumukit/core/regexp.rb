class Regexp
  def matches?(string)
    !!(self =~ string)
  end
end
