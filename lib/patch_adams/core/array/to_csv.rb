require 'csv'

class Array
  def to_csv
    CSV.generate do |csv|
      each { |hash| csv << hash.values }
    end
  end
end
