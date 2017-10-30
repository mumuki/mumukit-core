[:json_eq, :json_like].each do |it|

  def as_matcher_json(obj, options = {})
    new_options = options.with_indifferent_access
    new_options['only'] = [*new_options['only']].map &:to_s if new_options['only']
    new_options['except'] = [*new_options['except']].map &:to_s if new_options['except']
    if obj.instance_of? String
      JSON.parse(obj).as_json new_options
    else
      JSON.parse(JSON.unparse obj).as_json new_options
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