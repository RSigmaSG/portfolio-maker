require_relative 'lib/portfolio_maker/version'

Gem::Specification.new do |spec|
  spec.name          = 'portfolio-maker'
  spec.version       = PortfolioMaker::VERSION
  spec.authors       = ["'Sumer Gaikwad'"]
  spec.email         = ["'sg.comparch@gmail.com'"]

  spec.summary       = %q{portfolio simulator}
  spec.description   = %q{portfolio simulator}
  spec.homepage      = 'http://rubygems.org/gemsportfolio-maker'
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "http://rubygems.org/gemsportfolio-maker"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "http://rubygems.org/gemsportfolio-maker"
    spec.metadata["changelog_uri"] = "http://rubygems.org/gemsportfolio-maker"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = ["lib/portfolio_maker.rb", "lib/portfolio_maker/command_line_interface.rb", "lib/portfolio_maker/scraper.rb", "lib/portfolio_maker/portfolio.rb", "lib/portfolio_maker/stock.rb", "config/environment.rb"]
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_dependency "nokogiri"
  spec.add_development_dependency "rspec", "~> 3.2"
end
