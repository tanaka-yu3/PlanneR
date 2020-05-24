class UsersController < ApplicationController

	def items
	  @user = User.find(params[:user_id])
      @items = @user.items.all
	end

	def show
		@user = User.find(params[:id])
		@items = @user.items.page(params[:page]).per(5)
	end

	def sold_items
		@user = User.find(params[:user_id])
		@orders = Order.where(item: @user.items)
	end
end
