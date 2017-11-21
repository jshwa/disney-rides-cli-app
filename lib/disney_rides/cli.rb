class DisneyRides::CLI

    def start
      scrape_disney
      add_info
      menu
    end

    def scrape_disney
      ride = DisneyRides::Scraper.scrape_park("https://disneyland.disney.go.com/attractions/")
      DisneyRides::Ride.create_from_collection(ride)
    end

    def add_info
      DisneyRides::Ride.all.each do |ride|
        info = DisneyRides::Scraper.scrape_attraction("https://disneyland.disney.go.com#{ride.link}")
        ride.add_attraction_info(info)
      end
    end

    def menu
      puts "--------------------------"
      puts "Welcome to Disney Rides"
      puts "--------------------------"
      puts ""
      puts "What would you like to do?"
      puts "1. See Disney Resorts"
      puts "2. See thrill levels"
      puts "3. See fastpass rides"
      puts "4. Print all rides"
      puts "5. Exit"
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
      when 5
        exit
      end
      menu
    end

    def print_resorts
      puts ""
      puts "----------- Disney Resorts -----------"
      DisneyRides::Resort.all.uniq.each.with_index(1) {|r, i| puts "#{i}. #{r.name}"}
      puts ""
    end

    def print_thrill_lvl
      puts ""
      puts "----------- Thrill Levels -----------"
      DisneyRides::Thrill_lvl.all.uniq.each.with_index(1) {|r, i| puts "#{i}. #{r.name}"}
      puts ""
      puts "Which thrill level would you like more info on? Or type menu"
      input = gets.strip
      if input == "menu"
        menu
      else
        DisneyRides::Thrill_lvl.all.uniq[input.to_i-1].rides.each do |ride|
          print_ride(ride)
        end
      end
    end

    def print_fastpass
      fastpass = []
      DisneyRides::Ride.all.each do |ride|
        fastpass << ride if ride.fastpass == "Yes"
      end
      fastpass.each.with_index(1) {|ride, index| puts "#{index}. #{ride.name}"}
      puts ""
      puts "Which ride would you like to see more about? Or type menu"
      input = gets.strip
      if input == "menu"
        menu
      else
        print_ride(fastpass[input.to_i - 1])
      end
    end

    def print_ride(ride)
      puts ""
      puts "-----------#{ride.name}-----------"
      puts ""
      puts "Disney:             #{ride.resort.name}"
      puts "Park:               #{ride.park}"
      puts "Thrill Level:       #{ride.thrill_lvl.join(', ')}" unless ride.thrill_lvl == []
      puts "Hours:              #{ride.hours}" unless ride.hours == " to "
      puts "Fastpass:           #{ride.fastpass}"
      puts ""
      puts "Description:"
      puts "#{ride.desc}"
      puts ""
    end
end
