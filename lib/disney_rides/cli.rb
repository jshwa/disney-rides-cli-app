class DisneyRides::CLI

    def start
      menu
      scrape_disney
      add_info
    end

    def scrape_disney
      ride = DisneyRides::Scraper.scrape_park("https://disneyland.disney.go.com/attractions/")
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
      when 2
        print_thrill_lvl
      when 3
        print_fastpass
      when 4
        DisneyRides::Ride.all.each {|ride| print_ride(ride)}
      end
    end

    def print_resorts
      DisneyRides::Resort.all.uniq.each {|r| puts r.name}
    end

    def print_thrill_lvl
      DisneyRides::Thrill_lvl.all.uniq.each {|r| puts r.name}
    end

    def print_fastpass
      DisneyRides::Ride.all.each do |ride|
        puts ride.name if ride.fastpass == "Yes"
      end
    end

    def print_ride(ride)
      puts "-----------#{ride.name}-----------"
      puts "Disney:           #{ride.resort.name}"
      puts "Park:             #{ride.park}"
      puts "Thrill Level:     #{ride.thrill_lvl.name}"
      puts "Hours:            #{ride.hours}"
      puts "Fastpass:         #{ride.fastpass}"
      puts ""
      puts "Description:"
      puts "#{ride.desc}"
    end
end
