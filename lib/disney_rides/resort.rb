class DisneyRides::Resort
  attr_accessor :name, :rides, :url
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
    resort = self.new(name)
    resort
  end

  def add_ride(ride)
    self.rides << ride
  end

  # def self.find(resort)
  #   self.all.detect {|r| r.name == resort}
  # end
  #
  # def self.find_or_create(resort)
  #   self.find(resort) || self.create(resort)
  # end

  def self.create_from_collection(resorts)
    resorts.each do |resort, url|
      resort = self.create(resort)
      resort.url = url
    end
  end

end
