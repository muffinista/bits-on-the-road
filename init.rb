@generator = Namey::Generator.new

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

  contig = %W(AL AK AZ AR CA CO CT DE DC FL GA ID IL IN IA KS KY LA ME MD MA MI MN MS MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV WI WY)
  puts contig.inspect
  db[:places].where(state:contig).where("name not like '%historical%' AND lat <> 0 AND lon <> 0").order(Sequel.function(:RAND)).limit(100).each { |row|
    puts row.inspect
    p = Place.new(row[:name], row[:state], row[:lat], row[:lon])
    puts p.inspect
    @places << p
  }
  
  
  1.upto(6) {
    gender = rand >= 0.5 ? :female : :male
    first_name = @generator.send(gender, :all, false)
    last_name = @generator.send(:surname, :all)  
    
    a = Actor.new(first_name, last_name, gender)
    a.narrator = narrator
    a.hometown = @places.sample
    a.location = @places.sample  
    
    narrator = false
    puts a.inspect
    
    @actors << a
  }
end
