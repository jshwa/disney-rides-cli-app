require 'open-uri'
require 'nokogiri'
require 'watir'
require 'pry'

class DisneyRides::Scraper

  def self.scrape_park(park_url)
    browser = Watir::Browser.new :chrome
    browser.goto(park_url)
    sleep 2
    all_rides = Nokogiri::HTML(browser.html)

    park_attractions = []

    all_rides.css("li.card").each do |ride|
      park_attractions << {
        :name => ride.css("h2.cardName").text,
        :resort => "Disneyland",
        :park => "Adventureland",
        :hours => "8:00 AM to 12:00AM"
      }
    end
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
