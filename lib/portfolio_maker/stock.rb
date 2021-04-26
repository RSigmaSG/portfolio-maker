class Stock

  attr_accessor :name, :ticker, :price, :quantity, :equity, :market_cap

  @@all = []

  def initialize(stock_hash)

    stock_hash.each {|key, value| self.send(("#{key}="), value)}
    @quantity = self.update_quantity
    
  end

  def self.sell(ticker, amount)
  
    self.find_stock_with_ticker(ticker).equity -= amount
    if (self.find_stock_with_ticker(ticker).equity == 0) 
      @@all.delete(self.find_stock_with_ticker(ticker))
    else
      self.find_stock_with_ticker(ticker).update_quantity
    end
    
  end

  def make_hash_from_stock
    
    stock_info = {}

    stock_info[:name] = self.name
    stock_info[:price] = self.price
    stock_info[:market_cap] = self.market_cap

    stock_info
    
  end

  def update_quantity

    @quantity = @equity/(self.price.to_f)

  end

  def curr_equity
    
    @equity = @quantity * (self.price.to_f)

  end

  def update_stock_price
    
    self.price = Scraper.scrape_stock_page("https://finance.yahoo.com/quote/" + self.ticker)[:price]
    self.curr_equity

  end

  def price=(price)

    @price = price

  end


  def self.find_stock_with_ticker(ticker)

    stock = @@all.select{|stock|stock.ticker == ticker}

    stock == [] ? nil : stock[0]

  end

  def price

    @price.gsub(/[\s,]/ ,"").to_f

  end

  def display

    puts "#{@name} (#{@ticker}): stocks: #{@quantity} shares, equity: $#{self.curr_equity}"

  end

  def self.display_tickers
    
    @@all.each {|stock| print "|#{stock.ticker}"}
    puts "|"
  end

  def self.update_stocks

    #binding.pry
    price_update = 0
    @@all.each do |stock|
      curr_price = stock.price
      stock.update_stock_price
      price_update = stock.price - price_update
    end
    price_update
  end

  def self.create_or_buy_more(stock_hash, amount)

    if (!self.find_stock_with_ticker(stock_hash[:ticker]))
      stock_hash[:equity] = amount
      new_stock = self.new(stock_hash)
      @@all << new_stock
    else
      updating_stock = self.find_stock_with_ticker(stock_hash[:ticker])
      updating_stock.update_stock_price
      updating_stock.quantity += (amount/updating_stock.price)
    end
  end

  def self.all
    @@all
  end
end

