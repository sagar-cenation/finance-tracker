class StockPdf < Prawn::Document
	def initialize(user_stocks)
		super()
		@stocks = user_stocks
		user_stock
		# line_items
	end

	def user_stock
		text "Stock List", size: 30, style: :bold
	end

	# def line_items
	# 	move_down 20
	# 	# table line_item_rows
	# end

	# def line_item_rows
	# 	[["Name","Symbol","Price"]] + 
	# 	@stocks.line_items.map do |stock|
	# 		[stock.name, stock.ticker, stock.price]
	# 	end
	# end
end