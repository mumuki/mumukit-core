class Object
  def filled?
    self == false || present?
  end
end