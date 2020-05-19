class UsersController < ApplicationController

	def items
	  @user = User.find(params[:user_id])
      @user_items = @user.items.all
	end

	def show
		@user = User.find(params[:id])
		@items = @user.items.page(params[:page]).per(3)
	end

	def sold_items
		@user = User.find(params[:user_id])
		# @items = Items.orders.
	end
end
