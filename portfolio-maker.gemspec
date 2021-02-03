  
require_relative './lib/portfolio_maker/version'

Gem::Specification.new do |s|
  s.name        = 'portfolio-maker'
  s.version     = PortfolioMaker::VERSION
  s.date        = '2021-01-18'
  s.summary     = "Portfolio Maker"
  s.description = "Simulates a stock portfolio"
  s.authors     = ["Sumer Gaikwad"]
  s.email       = 'sg.comparch@gmail.com'
  s.files       = ["lib/portfolio_maker.rb", "lib/portfolio_maker/command_line_interface.rb", "lib/portfolio_maker/scraper.rb", "lib/portfolio_maker/portfolio.rb", "lib/portfolio_maker/stock.rb", "config/environment.rb"]
  s.homepage    = 'http://rubygems.org/gemsportfolio-maker'
  s.license     = 'MIT'
  s.executables << 'portfolio-maker'

  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", ">= 0"
  s.add_development_dependency "nokogiri", ">= 0"
  s.add_development_dependency "pry", ">= 0"
  s.add_development_dependency "open-uri", ">= 0"
  s.add_development_dependency "colorize", ">= 0"

end