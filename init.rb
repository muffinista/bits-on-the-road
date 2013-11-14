@generator = Namey::Generator.new

def generate_actor
  gender = rand >= 0.5 ? :female : :male
  first_name = @generator.send(gender, :common, false)
  last_name = @generator.send(:surname, :common)

  while !@actors.empty? && ( @actors.collect(&:first_name).include?(first_name) || @actors.collect(&:last_name).include?(last_name) )
    first_name = @generator.send(gender, :common, false)
    last_name = @generator.send(:surname, :common)
  end

  Actor.new(first_name, last_name, gender) 
end

def load_data
  narrator = true

  db_params = {
    :adapter => 'mysql2',
    :host => 'localhost',
    :database => 'eachtown',
    :user => 'root',
    :password => nil
  }
  db = Sequel.connect(db_params)

  #
  # restrict to continental us so we can get google directions
  #
  contig = %W(AL AK AZ AR CA CO CT DE DC FL GA ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY)
  db[:places].where(state:contig).where("name not like '%historical%' AND lat <> 0 AND lon <> 0").order(Sequel.function(:RAND)).limit(100).each { |row|
    p = Place.new(row[:name], row[:state], row[:lat], row[:lon])
    @places << p
  }
  
 
  1.upto(6) {
    a = generate_actor
    a.narrator = narrator
    a.hometown = @places.sample
    a.location = @places.sample  
    
    narrator = false
    
    @actors << a
  }
end
