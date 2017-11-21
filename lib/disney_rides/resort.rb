class DisneyRides::Resort
  attr_accessor :name, :rides, :url, :thrills
  @@all = []

  def initialize(name)
    @name = name
    @rides = []
    @thrills = []
    @@all << self
  end

  def self.all
    @@all
  end

  def self.create(name)
    resort = self.new(name)
    resort
  end

  def add_ride(ride)
    self.rides << ride
  end

  def add_thrill(thrill)
    self.thrills << thrill
  end

  def self.create_from_collection(resorts)
    resorts.each do |resort, url|
      resort = self.create(resort)
      resort.url = url
    end
  end

end
