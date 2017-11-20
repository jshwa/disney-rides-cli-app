require 'open-uri'
require 'nokogiri'
require 'watir'
require 'pry'

class DisneyRides::Scraper

  def self.scrape_park(park_url)
    browser = Watir::Browser.new :chrome
    browser.goto(park_url)
    all_rides = Nokogiri::HTML(browser.html)

    park_attractions = []

    all_rides.css("li.card").each do |ride|
      park_attractions << {
        :name => ride.css("h2.cardName").text,
        :resort => "Disneyland",
        :link => ride.css("div.detailIndicatorContainer a").attribute("href").value
      }
    end
    park_attractions
  end

  def self.scrape_attraction(attraction_url)
    additional_info = {}

    additional_info[:hours] = "8:00AM"
    additional_info[:park] = "Adventureland"
    additional_info[:thrill_lvl] = "Thrill Rides"
    additional_info[:desc] = "Venture deep inside a cursed temple aboard a rugged troop transport and embark on a fast-paced thrill ride to find Indiana Jones."
    additional_info[:fastpass] = "Yes"
    additional_info
  end
end
