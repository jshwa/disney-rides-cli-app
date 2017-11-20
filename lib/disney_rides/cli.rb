class DisneyRides::CLI

    def start
      menu
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
