class Array
  def assign_numbers!(selector: :number, start_at: 1)
    self.each_with_index do |r, i|
      r.send "#{selector}=", i+start_at
    end
  end
end
