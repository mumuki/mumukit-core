class Class
  class ContractBreachError < Exception
  end

  unless %w(RACK_ENV RAILS_ENV).any? { |it| ENV[it] == 'production' }
    alias_method :__new__, :new

    def new(*args, &block)
      validate_upholds_contract!
      __new__(*args, &block)
    end
  end

  def validate_upholds_contract!
    raise ContractBreachError.new "class #{name} does not implement contract #{contract_breaches}!" if breaches_contract?
  end
end
