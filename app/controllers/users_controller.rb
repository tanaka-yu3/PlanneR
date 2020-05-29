class UsersController < ApplicationController

	def items
	  @user = User.find(params[:user_id])
      @items = @user.items.page(params[:page]).per(5)
	end

	def show
		@user = User.find(params[:id])
		@price_sum = @user.items.joins(:orders)
		@sales = @price_sum.where("order_status = ?", 2).sum("orders.price")
		@items = @user.items.page(params[:page]).per(5)
		@order = @user.orders.where(order_status: 1).count
	end

	def sold_items
		@user = User.find(params[:user_id])
		@orders = Order.where(item: @user.items)
	end

end
