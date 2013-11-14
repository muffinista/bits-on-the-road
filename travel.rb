class Directions
  include HTTParty
  base_uri 'maps.googleapis.com'
  format :json

  #http://maps.googleapis.com/maps/api/directions/json?origin=Toronto&destination=Montreal&sensor=false
  
  def initialize
  end
  def directions(options={})
    #options.merge!({api_secret:@secret})
    self.class.get("/maps/api/directions/json", query:options)
  end
end


def trip(who:[], visiting:nil, dest:nil)
  start = who.first.location

  if dest.nil?
    dest = visiting.location
  end
  
  if who.size > 1
    travellers = who.collect(&:to_s).join(", ")
  else
    travellers = who.first.to_s
  end

  puts "#{travellers} is going from #{start} to visit #{visiting} at #{dest}"
  
  opts = {
    origin:start.to_s,
    destination:dest.to_s,
    sensor:false,
    avoid:'highways'
  }
  #&mode=bicycling

  who.each { |w|
    w.location = dest
  }
  
  return
  
  directions = Directions.new.directions(opts)
  r = directions["routes"].first
  puts r["summary"]
  r["legs"].each { |leg|
    puts leg.keys.inspect
    leg["steps"].each { |step|
      puts step["html_instructions"]
    }
  }

end
