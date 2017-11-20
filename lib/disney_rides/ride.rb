class DisneyRides::Ride
  attr_accessor :name, :park, :location, :hours, :link, :thrill_lvl, :desc, :fastpass

  @@all = []

  def initialize(ride_hash)
    ride_hash.each {|name, info| send "#{name}=", info}
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create_from_collection(rides_list)
    rides_list.each {|ride| self.new(ride)}
  end

  def add_attraction_info(info_hash)
    info_hash.each {|name, info| send "#{name}=", info}
  end
end
