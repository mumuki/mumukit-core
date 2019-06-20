require 'active_model/naming'

module ActiveModel::Naming
  def name_model_as(other)
    define_singleton_method :model_name do
      other.model_name
    end
  end

  def demodulized_model_name
    define_singleton_method :model_name do
      ActiveModel::Name.new(self, nil, name.demodulize)
    end
  end
end
