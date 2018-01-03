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

    failure_message_for_should do |actual|
      <<-EOS
      expected: #{as_matcher_json(expected, options)} (#{expected.class})
           got: #{as_matcher_json(actual, options)} (#{actual.class})
      EOS
    end

    failure_message_for_should_not do |actual|
      <<-EOS
      expected: value != #{as_matcher_json(expected, options)} (#{expected.class})
           got:          #{as_matcher_json(actual, options)} (#{actual.class})
      EOS
    end
  end

end