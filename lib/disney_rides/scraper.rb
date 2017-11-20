class DisneyRides::Scraper

  def scrape_park(park_url)
    park_attractions = []

    park_attractions << {
      :name => "Indiana Jones",
      :park => "Disneyland",
      :location => "Adventureland",
      :hours => "8:00 AM to 12:00AM"
    }
  end

  def scrape_attraction(attraction_url)

  end
end
