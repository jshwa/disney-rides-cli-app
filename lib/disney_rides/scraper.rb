class DisneyRides::Scraper

  def self.scrape_park(park_url)
    park_attractions = []

    park_attractions << {
      :name => "Indiana Jones",
      :park => "Disneyland",
      :location => "Adventureland",
      :hours => "8:00 AM to 12:00AM"
    }
    park_attractions
  end

  def self.scrape_attraction(attraction_url)
    additional_info = {}

    additional_info[:thrill_lvl] = "Thrill Rides"
    additional_info[:desc] = "Venture deep inside a cursed temple aboard a rugged troop transport and embark on a fast-paced thrill ride to find Indiana Jones."
    additional_info[:fastpass] = "Yes"
    additional_info
  end
end
