class OrdersController < ApplicationController
	before_action :authenticate_user!

	def index
		@user = User.find(params[:user_id])
		@orders = @user.orders.all
	end

	def new
		@item = Item.find(params[:item_id])
		@order = @item.orders.new
	end

	def confirm
		@item = Item.find(params[:item_id])
		@order = @item.orders.new(order_params)
	end

	def create
		@item = Item.find(params[:item_id])
		@order = @item.orders.new(order_params)
		@order.user_id = current_user.id
		@order.save
		redirect_to item_thanks_path
	end

	def thanks

	end

	private

	def order_params
		params.require(:order).permit(:user_id, :item_id, :first_day, :last_day, :amount)
	end
end
