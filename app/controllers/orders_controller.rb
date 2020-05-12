class OrdersController < ApplicationController

	before_action :confirm, only: [:create]
	
	def new
		@order = current_user.orders.new
		@item = Item.find(params[:item_id])
	end

	def confirm
		@order = current_user.orders.new(order_params)
	end

	def create
		@order = current_user.orders.new(order_params)
		@order.save
	end

	private
	def order_params
		params.reqiure(:order).permit(:user_id, :item_id, :start_day, :finish_day, :amout)
	end
end
