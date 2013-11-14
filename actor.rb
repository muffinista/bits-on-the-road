class Actor < Struct.new(:first_name, :last_name, :gender, :emotion, :hometown, :narrator)
  attr_accessor :location

  def to_s(short=true)
    if short
      first_name
    else
      "#{first_name} #{last_name}"
    end
  end

  def location
    @location.nil? ? hometown : @location
  end
end
