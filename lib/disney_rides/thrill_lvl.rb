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

  def self.rides
    @rides
  end

  def self.create(name)
    thrill_lvl = self.new(name)
    thrill_lvl
  end

  def add_ride(ride)
    self.rides << ride
  end

  def self.find(thrill_lvl)
    self.all.detect {|r| r.name == thrill_lvl}
  end

  def self.find_or_create(thrill_lvl)
    self.find(thrill_lvl) || self.create(thrill_lvl)
  end

end
