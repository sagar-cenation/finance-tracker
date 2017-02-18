class Stock < ApplicationRecord
	has_many :user_stocks
	has_many :users, through: :user_stocks

	def self.find_by_ticker(ticker_symbol)
		where(ticker: ticker_symbol).first
	end
	

	#class level methods
	def self.new_from_lookup(ticker_symbol)
		lookup_up_stock = StockQuote::Stock.quote(ticker_symbol)
		return nil unless lookup_up_stock.name #return nil for invalid search

		new_stock = new(ticker: lookup_up_stock.symbol, name: lookup_up_stock.name)
		new_stock.last_price = new_stock.price
		new_stock
	end

	def price 
		closing_price = StockQuote::Stock.quote(ticker).close
		return "#{closing_price} (Closing)" if closing_price

		opening_price = StockQuote::Stock.quote(ticker).open
		return "#{opening_price} (Opening)" if opening_price
		'Unavailable' #otherwise
	end
end
