RSpec::Matchers.define :json_like do |expected, options={}|
  except = options[:except] || []
  match do |actual|
    actual.as_json.with_indifferent_access.except(except) == expected.as_json.with_indifferent_access
  end

  failure_message_for_should do |actual|
    <<-EOS
    expected: #{expected.as_json} (#{expected.class})
         got: #{actual.as_json} (#{actual.class})
    EOS
  end

  failure_message_for_should_not do |actual|
    <<-EOS
    expected: value != #{expected.as_json} (#{expected.class})
         got:          #{actual.as_json} (#{actual.class})
    EOS
  end
end