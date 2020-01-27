class Class
  class ContractBreachError < Exception
  end

  def validate_complies_with_contract!
    raise ContractBreachError.new "class #{name} does not implement contract #{contract_breaches}!" if breaches_contract?
  end
end
