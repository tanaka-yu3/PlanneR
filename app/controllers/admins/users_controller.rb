class Admins::UsersController < ApplicationController
	before_action :authenticate_admin!

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		@orders = @user.items.joins(:orders).where("order_status = ?", 3)
		@price_sum = @orders.sum("orders.price")
		@items = @user.items.page(params[:page]).per(5)
	end

	def order_status_update
		@user = User.find(params[:user_id])
		@order = Order.where(item: @user.items)
		@orders = @order.where("order_status = ?" ,3)
		@orders.each do |order|
			  order.update(order_status: 4)
		end
		 redirect_to request.referer
	end

	def bank
		@user = User.find(params[:user_id])
	end
end



