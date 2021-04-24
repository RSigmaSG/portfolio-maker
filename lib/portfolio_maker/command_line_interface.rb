class PortfolioMaker::CommandLineInterface

  attr_accessor :user_portfolio

  def run
    capital = 0
    loop do
      puts "How much would you like to deposit into your account?"
      capital = gets.chomp
      break if ((capital.to_i > 0) && capital.scan(/\D/).empty?)
      puts "Please enter correct value"
    end
    @user_portfolio = Portfolio.new(capital.to_i)
    main_menu

  end
  
  def user_portfolio

    @user_portfolio

  end


  def main_menu

    main_menu_loop_bool = true
    loop do
      puts "Select one of the following options by entering one of the below option number in your ternminal:"
      puts "1. Manually enter stock ticker"
      puts "2. Top 10 most active stocks"
      puts "3. My portfolio"
      puts "4. Quit"

      input = menu_input(4)

      case input
        when 1 
          stock_find
        when 2
          most_active
        when 3
          portfolio_menu
        when 4
          main_menu_loop_bool = false
      end
      break if !(main_menu_loop_bool)
    end
    abort("Thank you for using this portfolio interface!")
  end

  def stock_find

    stock_info = {}
    #binding.pry
    loop do
      puts "Please enter stock ticker"

      ticker = gets.chomp
      

      stock_info = Scraper.scrape_stock_page("https://finance.yahoo.com/quote/" + ticker)

      break if (stock_info != nil)
      puts "Please enter a proper stock ticker (No ETFs, Crypto, Indexes etc.)"
    end
    
    puts "Name: #{stock_info[:name]}, Price: $#{stock_info[:price]}, market cap: $#{stock_info[:market_cap]}"
    puts "Select one of the following options by entering one of the below option number in your ternminal:"
    puts "1. Add stock to portfolio or buy more"
    puts "2. Return to main menu"

    input = menu_input(2)
    #binding.pry
    case input
    when 1 
      amount = 0
      loop do
        puts "Select what amount would you like to buy?\n current cash = $#{user_portfolio.cash}"
        amount = gets.chomp

        break if (!(amount.to_i > user_portfolio.cash || amount.to_i <= 0) && amount.scan(/\D/).empty?)
        
        puts "Please enter valid amount within availible cash"
        
      end
      #binding.pry
      user_portfolio.create_or_buy_more(stock_info, amount.to_i)
      #binding.pry
      puts "Bought #{amount.to_i / stock_info[:price].gsub(/[\s,]/ ,"").to_f} shares of #{stock_info[:name]}"
    when 2
      
    end
  end

  def most_active

    puts "Printing top 10 trending stocks"

     Scraper.scrap_trending_stocks_page


  end

  def portfolio_menu

    portfolio_loop_bool = true
    loop do
      puts "Manage your portfolio by entering one of the below option number in your ternminal:"
      puts "1. View my portfolio"
      puts "2. Sell stock"
      puts "3. Add funds"
      puts "4. Withdraw funds"
      puts "5. Return to main menu"

      input = menu_input(5)

      case input
        when 1 
          user_portfolio.display
        when 2
          if(user_portfolio.stocks.empty?)
            puts "Porfolio is empty"
            portfolio_menu
          end
          ticker = ""
          amount = 0
          loop do
            puts "Enter ticker for stock you want to sell or enter ""cancel"" to return to portfolio menu"
              puts "Tickers:"
              Stock.display_tickers
              ticker = gets.chomp

              break if (Stock.find_stock_with_ticker(ticker))

              puts "Please enter a valid ticker"
              
          end
          if !(amount == "cancel") 
            loop do
                #binding.pry
                puts "How much would you like to sell of $#{Stock.find_stock_with_ticker(ticker).update_stock_price} of the stock or enter ""cancel"" to return to portfolio menu"
                amount = gets.chomp
                
                break if (!(amount.to_i <= 0 || amount.to_i > Stock.find_stock_with_ticker(ticker).equity.to_f) && amount.scan(/\D/).empty?)
                
                puts "Please input correct value"
            end
          end
          user_portfolio.sell_stock(ticker, amount.to_i) if !(amount == "cancel") 
          puts "Sold $#{amount} of #{ticker}" if !(amount == "cancel") 
        when 3
          amount = ""
          loop do
            puts "How much would you like to deposit or enter ""cancel"" to return to portfolio menu"
            amount = gets.chomp
            
            break if (!(amount.to_i <= 0) && amount.scan(/\D/).empty?)
            
            puts "Please input correct value"
          end
          user_portfolio.deposit(amount.to_i) if !(amount == "cancel")
        when 4
          loop do
            puts "How much would you like to withdraw or enter ""cancel"" to return to portfolio menu \n current cash = $#{user_portfolio.cash}"
            amount = gets.chomp

            break if (!(amount.to_i <= 0 || amount.to_i > user_portfolio.cash) && amount.scan(/\D/).empty?)
      
            puts "Please input correct value"
          end
          user_portfolio.withdraw(amount.to_i) if !(amount == "cancel")
        when 5
          portfolio_loop_bool = false
      end
      break if !(portfolio_loop_bool)
    end
  end


  def menu_input(max)
    input = ""
    loop do
      input = gets.chomp
      break if (input.to_i.between?(1,max) && input.scan(/\D/).empty?)
      puts "Please enter an integer number between than 1 and #{max}:"
    end

    return input.to_i

  end
end
