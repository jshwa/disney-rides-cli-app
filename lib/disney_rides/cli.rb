class DisneyRides::CLI

    def start
      scrape_disney
      add_info
      menu
    end

    def scrape_disney
      ride = DisneyRides::Scraper.scrape_park("x")
      DisneyRides::Ride.create_from_collection(ride)
    end

    def add_info
      DisneyRides::Ride.all.each do |ride|
        info = DisneyRides::Scraper.scrape_attraction(ride.link)
        ride.add_attraction_info(info)
      end
    end

    def menu
      puts "Welcome to Disney Rides"
      puts "What would you like to do?"
      puts "1. See rides by resort"
      puts "2. See rides by thrill level"
      puts "3. See fastpass rides"
      puts "4. Print all rides"
      input = gets.strip.to_i

      case input
      when 1
        print_resorts
      when 4
        DisneyRides::Ride.all.each {|ride| print_ride(ride)}
      end
    end

    def print_resorts
      DisneyRides::Resort.all.uniq.each {|r| puts r.name}
    end

    def print_ride(ride)
      puts "-----------#{ride.name}-----------"
      puts "Disney:           #{ride.resort}"
      puts "Park:             #{ride.park}"
      puts "Thrill Level:     #{ride.thrill_lvl}"
      puts "Hours:            #{ride.hours}"
      puts "Fastpass:         #{ride.fastpass}"
      puts "Description:      #{ride.desc}"
    end
end
