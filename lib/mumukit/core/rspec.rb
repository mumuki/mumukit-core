[:json_eq, :json_like].each do |it|

  def as_matcher_json(obj, options = {})
    if obj.instance_of? String
      JSON.parse(obj).with_indifferent_access.as_json options
    else
      obj.as_json options
    end
  end

  RSpec::Matchers.define it do |expected, options={}|
    match do |actual|
      as_matcher_json(actual, options) == as_matcher_json(expected, options)
    end

    message = proc do |actual|
      <<-EOS
      expected: #{as_matcher_json(expected, options)} (#{expected.class})
           got: #{as_matcher_json(actual, options)} (#{actual.class})
      EOS
    end

    negated_message = proc do |actual|
      <<-EOS
      expected: value != #{as_matcher_json(expected, options)} (#{expected.class})
           got:          #{as_matcher_json(actual, options)} (#{actual.class})
      EOS
    end

    if respond_to? :failure_message
      failure_message(&message)
      failure_message_when_negated(&message)
    else
      failure_message_for_should(&:message)
      failure_message_for_should_not(&:message)
    end
  end

end
