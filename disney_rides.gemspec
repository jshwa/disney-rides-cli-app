
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "disney_rides/version"

Gem::Specification.new do |spec|
  spec.name          = "disney_rides"
  spec.version       = DisneyRides::VERSION
  spec.authors       = ["Joshua Palacios"]
  spec.email         = ["palacios.joshua@gmail.com"]

  spec.summary       = %q{Provides info about rides at various disney resorts}
  spec.description   = %q{This Ruby Gem is a school project to demonstrate scraping websites and object oriented programming. The gem scrapes the websites of various Disney resorts and returns info about the rides at each resort. Users can use the CLI to view rides categorized by thrill level or fastpass availability, or can choose to view all rides at a given resort.}
  spec.homepage      = "https://github.com/jshwa"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"

  spec.add_dependency "nokogiri", "~>1.8"
  spec.add_dependency "watir", "~> 6.0"

end
