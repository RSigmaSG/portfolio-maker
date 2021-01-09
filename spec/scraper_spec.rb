require "spec_helper"

describe "Scraper" do

  let!(:ticker_index_array) {[{:ticker=>"GBTC", :name=>"Bitcoin Invest"},
                               {:ticker=>"QS", :name=>"Quantumscape"},
                               {:ticker=>"GOOG", :name=>"Alphabet C"}]}

  let!(:stock_alphabet_hash) {{:name => "Alphabet Inc.", :ticker => "GOOG", :price => "1,735.29", :market_cap => "1.173T"}}

  let!(:stock_tesla_hash) {{:name => "Tesla, Inc.", :ticker => "TSLA", :price => "755.98", :market_cap => "716.594B"}}

  describe "#scrap_trending_stocks_page" do
    it "is a class method that scrapes the top stocks page and a returns an array of hashes in which each hash represents one student" do
      scraped_tickers = Scraper.scrap_trending_stocks_page
      expect(scraped_tickers).to be_a(Array)
      expect(scraped_tickers.first).to have_key(:ticker)
      expect(scraped_tickers.first).to have_key(:name)
      expect(scraped_tickers).to include(ticker_index_array[0], ticker_index_array[1], ticker_index_array[2])
    end
  end

  describe "#scrape_profile_page" do
    it "is a class method that scrapes a stock page and returns a hash of attributes describing an individual stock" do
      stock_url = "https://finance.yahoo.com/quote/GOOG"
      scraped_stock = Scraper.scrape_stock_page(stock_url)
      expect(scraped_stock).to be_a(Hash)
      expect(scraped_stock).to match(stock_alphabet_hash)
    end

    it "is a class method that scrapes a stock page and returns a hash of attributes describing an individual stock" do
      stock_url = "https://finance.yahoo.com/quote/TSLA"
      scraped_stock = Scraper.scrape_stock_page(stock_url)
      expect(scraped_stock).to be_a(Hash)
      expect(scraped_stock).to match(stock_tesla_hash)
    end
  end
end
