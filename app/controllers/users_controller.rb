class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@items = @user.items.all
		@orders =@user.orders.all
	end
end
