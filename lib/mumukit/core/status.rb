[:passed, :passed_with_warnings, :failed, :errored, :aborted].each do |sym|
  s = sym.to_s.freeze
  selector = "#{s}?"
  NilClass.class_eval do
    define_method(selector) { false }
  end
  String.class_eval do
    define_method(selector) { self == s }
  end
  Symbol.class_eval do
    define_method(selector) { self == sym }
  end
end
