require 'csv'

class Array
  def merge_numbers!(key=:number)
    self.each_with_index do |r, i|
      r.send "#{key}=", i+1
    end
  end

  def to_csv
    CSV.generate do |csv|
      each { |hash| csv << hash.values }
    end
  end

  def to_deep_struct
    map { |val| (val.is_a?(Hash) || val.is_a?(Array)) ? val.to_deep_struct : val }
  end
end
