class Place < Struct.new(:name, :state, :lat, :lon)
  def to_s
    "#{name}, #{state}"
  end
end
