require 'open-uri'
require 'pry'

class Scraper

  def self.scrap_trending_stocks_page
    
    stock_hash_arr = []
    
    doc = Nokogiri::HTML(open("https://www.investing.com/equities/trending-stocks"))



    top_stocks =  doc.css('table tbody tr td a')

    i = 0

    10.times do |index|
      
      stock_url = "https://www.investing.com" + top_stocks[i].attribute("href").value
      stock_ticker = Nokogiri::HTML(open(stock_url)).css(".instrumentHeader h2").text.split(" ")[0]
      
      #puts  {:ticker => stock_ticker, :name => top_stocks[i].text}
      puts "#{index + 1}. #{stock_ticker} #{top_stocks[i].text}"
      
      i+=1
      
    end
    
   #binding.pry
   stock_hash_arr
    
  end

  def self.scrape_stock_page(stock_url)
    
    doc = Nokogiri::HTML(open(stock_url))

    if ((doc.css("#quote-header-info div div div")).empty? || doc.css("#quote-header-info div div div span")[3].text == "")
      return nil
    end

    #binding.pry
    stock = {}

    stock_name =  doc.css("#quote-header-info div div div")[0].text.split(" ")
    stock[:ticker] = stock_name.pop.split(/[()]/)[1]
    stock[:name] = stock_name.join(" ")
    stock[:price] =  doc.css("#quote-header-info div div div span")[3].text
    stock[:market_cap] =  doc.css("#quote-summary div span")[13].text
    
    stock
    #binding.pry

  end

end

