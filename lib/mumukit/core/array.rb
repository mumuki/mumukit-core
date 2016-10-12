require 'csv'

class Array
  def merge_numbers!(key=:number)
    self.each_with_index do |r, i|
      r.send "#{key}=", i+1
    end
  end

  def to_h
    Hash[self]
  end

  def to_csv
    CSV.generate do |csv|
      each { |hash| csv << hash.values }
    end
  end
end