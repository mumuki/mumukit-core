require 'csv'

class Array
  # TODO add an option to handle headers and keys
  def to_csv
    CSV.generate do |csv|
      each { |hash| csv << hash.values }
    end
  end
end
