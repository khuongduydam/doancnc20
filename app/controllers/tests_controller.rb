class TestsController < ActionController::Base
	def index
		OrderItem.last.update(quantity: params[:price])		
	end
end