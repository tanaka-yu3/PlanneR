class UsersController < ApplicationController
	before_action :authenticate_user! or before_action :authenticate_admin!

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
		##売上金バリデート
		@bank = @user.bank_name && @user.bank_account_kind && @user.bank_branch_code && @user.bank_account_number
	end

	def sold_items
		@user = User.find(params[:user_id])
		@orders = Order.where(item: @user.items).page(params[:page]).per(3)
	end

end

