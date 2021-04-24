class Portfolio

    attr_accessor :capital, :cash, :invested
  
    def initialize(capital)
      
      @capital = capital
      @cash = capital
      invested

    end
    
    def stocks

      Stock.all

    end
    
    def update

      if !(stocks.empty?)
        value_change = Stock.update_stocks
        @invested += value_change
        @capital += value_change
        
      end

    end

    def invested

      @invested = 0
      stocks.each{|stock| @invested+=stock.equity}
      @invested
    end

    def display
      
      self.update
      puts "Amount invested = $#{self.invested}"
      puts "Cash availible = $#{self.cash}"
      if (!stocks.empty?)

        stocks.each{|stock|stock.display}

      end


    end
    def create_or_buy_more(stock_hash, amount)

      @cash -= amount
      @invested += amount
      Stock.create_or_buy_more(stock_hash, amount)

    end

    def sell_stock(ticker, amount)


      Stock.sell(ticker, amount)
      @invested -= amount
      @cash += amount
      
    end
    
    def deposit(amount)

      @cash += amount
      @capital += amount

    end

    def withdraw(amount)

      @cash -= amount
      @capital -= amount       

    end
    
  end
  
  