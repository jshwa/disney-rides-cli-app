class DisneyRides::CLI
  attr_accessor :current_resort

  RESORTS = {
    "Walt Disney World Resort, FL" => "https://disneyworld.disney.go.com",
    "Disneyland Resort, CA" => "https://disneyland.disney.go.com",
    "Disneyland Resort Paris" => "https://www.disneylandparis.co.uk",
    "Hong Kong Disneyland Resort" => "https://www.hongkongdisneyland.com",
    "Shanghai Disney Resort" => "https://www.shanghaidisneyresort.com/en"
  }

    def initialize
      puts "--------------------------------------"
      puts "       Welcome to Disney Rides"
      puts "--------------------------------------"
      DisneyRides::Resort.create_from_collection(RESORTS)
    end

    def start
      print_resorts
    end

    def print_resorts
      puts ""
      puts "----------- Disney Resorts -----------"
      DisneyRides::Resort.all.each.with_index(1) {|r, i| puts "#{i}. #{r.name}"}
      puts ""
      puts "Select a disney resort to see its rides"
      input = gets.strip.to_i
      self.current_resort = DisneyRides::Resort.all[input-1]
      puts "Just a second. Finding your info..."
      if current_resort.rides == []
        scrape_disney
        add_info
      end
      menu
    end

    def scrape_disney
      ride = DisneyRides::Scraper.scrape_park("#{current_resort.url}/attractions/")
      ride.each {|r| r[:resort] = current_resort}
      DisneyRides::Ride.create_from_collection(ride)
    end

    def add_info
      current_resort.rides.each do |ride|
        if current_resort.name == "Disneyland Resort, CA"
          info = DisneyRides::Scraper.scrape_attraction("#{current_resort.url}#{ride.link}")
        else
          info = DisneyRides::Scraper.scrape_attraction(ride.link)
        end
        ride.add_attraction_info(info)
      end
    end

    def menu
      puts "What would you like to do?"
      puts "1. See thrill levels at #{current_resort.name}"
      puts "2. See fastpass rides at #{current_resort.name}"
      puts "3. Print all rides at #{current_resort.name}"
      puts "4. See Disney Resorts"
      puts "5. Exit"
      input = gets.strip.to_i

      case input
      when 1
        print_thrill_lvl
      when 2
        print_fastpass
      when 3
        print_ride_list
      when 4
        print_resorts
      when 5
        exit
      else
        menu
      end
      menu
    end

    def print_thrill_lvl
      puts ""
      puts "----------- Thrill Levels -----------"
      if current_resort.name == "Disneyland Resort Paris"
        puts "Sorry, thrill levels currently unavailable for Paris"
        puts ""
        menu
      else current_resort.thrills.uniq.each.with_index(1) {|r, i| puts "#{i}. #{r.name}"}
        puts ""
        puts "Which thrill level would you like more info on? Or type menu"
        input = gets.strip
        if input == "menu"
          menu
        else
          current_resort.thrills.uniq[input.to_i-1].rides.each.with_index(1) {|ride, index| puts "#{index}. #{ride.name}"}
          puts ""
          puts "Which ride would you like to see more about? Or menu"
          ride_index = gets.strip
          if ride_index == "menu"
            menu
          else
            print_ride(current_resort.thrills.uniq[input.to_i-1].rides[ride_index.to_i-1])
            menu
          end
        end
      end
    end

    def print_fastpass
      fastpass = current_resort.rides.select {|ride| ride.fastpass == "Yes"}
      puts ""
      puts "----------- Fastpass Rides -----------"
      if current_resort.name == "Disneyland Resort Paris"
        puts "Sorry, Fastpass info currently unavailable for Paris"
        puts ""
        menu
      else
        puts ""
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
    end

    def print_ride_list
      puts ""
      puts "-----------Rides at #{current_resort.name}-----------"
      current_resort.rides.each.with_index(1) {|ride,index| puts "#{index}. #{ride.name}"}
      puts ""
      puts "Which ride would you like to see more about?"
      input = gets.strip.to_i
      print_ride(current_resort.rides[input-1])
      menu
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
