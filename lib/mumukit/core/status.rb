class NilClass
  def passed?
    false
  end

  def failed?
    false
  end

  def errored?
    false
  end
end

class String
  def passed?
    self == 'passed'.freeze
  end

  def failed?
    self == 'failed'.freeze
  end

  def errored?
    self == 'errored'.freeze
  end
end

class Symbol
  def passed?
    self == :passed
  end

  def failed?
    self == :failed
  end

  def errored?
    self == :errored
  end
end
