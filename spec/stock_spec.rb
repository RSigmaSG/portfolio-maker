require "spec_helper"

describe "Stock" do 

    let(:stock){Stock.new}
  let!(:student_index_array) {[{:name=>"GOOG", :location=>"New York, NY"},
 {:name=>"Bacon McRib", :location=>"Kansas City, MO"},
 {:name=>"Alisha McWilliams", :location=>"San Francisco, CA"},
 {:name=>"Daniel Fenjves", :location=>"Austin, TX"},
 {:name=>"Arielle Sullivan", :location=>"Chicago, IL"},
 {:name=>"Sushanth Bhaskarab", :location=>"Portland, OR"},
 {:name=>"Sushanth Bhaskarab", :location=>"Portland, OR"}]}

 let!(:student_hash) {{:twitter=>"someone@twitter.com",
 :linkedin=>"someone@linkedin.com",
 :github=>"someone@github.com",
 :blog=>"someone@blog.com",
 :profile_quote=>"\"Forget safety. Live where you fear to live. Destroy your reputation. Be notorious.\" - Rumi",
 :bio=>
  "I was in southern California for college (sun and In-n-Out!), rural Oregon for high school (lived in a town with 1500 people and 3000+ cows), and Tokyo for elementary/middle school."}}


  let!(:student) {Stock.new({:name=>"Alex Patriquin", :location=>"New York, NY"})}
  
  after(:each) do 
    Stock.class_variable_set(:@@all, [])
  end
  describe "#new" do
    it "takes in an argument of a hash and sets that new student's attributes using the key/value pairs of that hash." do 
      expect{Stock.new({:name = "Google", :ticker = "GOOG", :price = "1000", :equity = "4000"})}.to_not raise_error
      expect(stock.name).to eq("Google")
      expect(stock.ticker).to eq("GOOG")
      expect(stock.quantity).to eq(4)
    end 

    it "adds that new student to the Student class' collection of all existing students, stored in the `@@all` class variable." do 
      expect(Stock.class_variable_get(:@@all).first.name).to eq("Google")
    end
  end

  describe '#display' do
    it 'prints a stock' do
      expect(Stock.display).to match_array([])
    end
  end

  describe '.all' do
    it 'returns the class variable @@all' do
        Stock.class_variable_set(:@@all, [])
      expect(Stock.all).to match_array([])
    end
  end
end
