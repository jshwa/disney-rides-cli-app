require 'open-uri'
require 'nokogiri'
require 'watir'
require 'pry'

class DisneyRides::Scraper

  def self.scrape_resorts(disney_home)
    all_resorts = Nokogiri::HTML(open(disney_home))

    resorts = []
    
    all_resorts.css("div#Parks-Destinations div.footer-panel-content li").each do |resort|
      resorts << {
        :name => resort.css("a").text,
        :url => resort.css("a").attribute("href").value
      }
    end
    resorts
  end

  def self.scrape_park(park_url)
    browser = Watir::Browser.new :chrome
    browser.goto(park_url)
    all_rides = Nokogiri::HTML(browser.html)

    park_attractions = []

    all_rides.css("li.card").each do |ride|
      park_attractions << {
        :name => ride.css("h2.cardName").text,
        :resort => "Disneyland",
        :link => ride.css("a").attribute("href").value
      }
    end
    park_attractions
  end

  def self.scrape_attraction(attraction_url)
    ride = Nokogiri::HTML(open(attraction_url))

    additional_info = {}

    additional_info[:park] = ride.css("p.locationLandArea").text.strip
    additional_info[:thrill_lvl] = ride.css("p.thrillFactorText").text.split(", ")
    additional_info[:hours] = "#{ride.css("li time.timeStart").text.strip.split("  ")[0]} to #{ride.css("li time.timeEnd").text.strip.split("  ")[0]}"
    additional_info[:desc] = ride.css("p.finderDetailsPageSubtitle").text.strip
    additional_info[:fastpass] = ride.css("div.atAGlanceItem span a").text == "FastPass Offered" ? "Yes" : "No"
    additional_info
  end
end
