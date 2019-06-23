require 'active_model/naming'

module ActiveModel::Naming
  def name_model_as(other)
    define_singleton_method :model_name do
      other.model_name
    end
  end
end
