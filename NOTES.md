Disney Rides CLI Gem

1. Present menu to the user
    -See rides by park - Print list of all the disney parks
    -See rides by thrill level - print list of rides by thrill level
    -See FastPass rides
    -Print all rides

2. Choosing a ride will present the user with more info about the ride

--------------------
CLI
  - creates a constant that is an array of hashes :park => URLs for all the disney parks
  - #find_rides takes the array of hashes and calls #scrape_park on each URL. It also assigns the :park name to the ride if it is pulled from that park
  - #add_info takes each attraction's URL and calls scrape_attraction
  - #menu prints the menu
  - rides by park returns park.all
  - rides by thrill level returns thrill_lvl.all
  - FastPass Rides prints rides where :fastpass != nil

Scraper class
  - scrape_park takes an argument of a URL and creates an array of hashes with info about each attraction
    park_attractions = [{
      :name => ,:park => , :location => , :hours => , :link =>}, {etc.}  ]
  - scrape_attraction takes the URL to the attraction and adds additional information to the attraction's hash
    {:thrill_lvl, :desc, :fastpass}

Rides class
  - initializes with a hash
  - adds to @@all
  - .create_from_collection - creates new students from the scraped array (or any other array of hashes)
  - #add_attraction_info - adds more info that has been scraped (or any other hash)
  - .all
  - park=(park) calls park.add_ride to add itself to the park object
  - thrill_lvl(thrill_lvl) calls trill_lvl.add_ride to add itself to the thrill_lvl object

Park class
  - .create - instantiates a park and adds it to @@all
  - add_ride - adds ride to instance variable of all rides
  - .find_or_create_by_name - returns park object or instantiates one and returns it

Thrill Class
  - .create - instantiates a park and adds it to @@all
  - add_ride - adds ride to instance variable of all rides
  - .find_or_create_by_name - returns park object or instantiates one and returns it
