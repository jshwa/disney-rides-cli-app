class DisneyRides::CLI

    def start
      scrape_disney
      add_info
      menu
    end

    def scrape_disney
      ride = scrape_park("x")
      Ride.create_from_collection(ride)
    end

    def add_info
      Ride.all.each do |ride|
        info = scrape_attraction(ride.link)
        ride.add_attraction_info(info)
      end
    end

    def menu
      puts "Welcome to Disney Rides"
      puts "What would you like to do?"
      puts "1. See rides by park"
      puts "2. See rides by thrill level"
      puts "3. See fastpass rides"
      puts "4. Print all rides"
      input = gets.strip.to_i
    end

    def print_ride(ride)
      puts "-----------#{ride.name}-----------"
      puts "Disney:           #{ride.location}"
      puts "Park:             #{ride.park}"
      puts "Thrill Level:     #{ride.thrill_lvl}"
      puts "Hours:            #{ride.hours}"
      puts "Fastpass:         #{ride.fastpass}"
      puts "Description:      #{ride.description}"
    end
end
