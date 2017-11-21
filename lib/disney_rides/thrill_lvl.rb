class DisneyRides::Thrill_lvl
  attr_accessor :name, :rides
  @@all = []

  def initialize(name)
    @name = name
    @rides = []
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create(name)
    thrill_lvl = self.new(name)
    thrill_lvl
  end

  def add_ride(ride)
    self.rides << ride
  end
end
