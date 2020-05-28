class Admins::UsersController < ApplicationController
	before_action :authenticate_admin!

	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
		orders = @user.items.joins(:orders).where("(order_status = ?) OR (order_status = ?)", 3, 4 )
		@price_sum = orders.sum("orders.price")
		@items = @user.items.page(params[:page]).per(5)
		# @order = orders.each do |order|
		# 	order = orders.find_by(id: order.id)
		# end

	end

	def order_status_update
		@user = User.find(params[:user_id])
		@orders = Order.where("(order_status = ?) OR (order_status = ?)", 3, 4 )
		#orders = @user.where("(order_status = ?) OR (order_status = ?)", 3, 4 )
		@orders.each do |order|
			if order.order_status == 3
			  order.update(order_status: 4)
			else
			  order.update(order_status: 5)
			end
		end
		 redirect_to request.referer
	end


		# @order = @order_all.each do |order|
		# 	order.order_status
		# end
		# #
		# @order = @orders.each do |order|
		# 	 order = order.id
		# end
		# order_first = Order.where(item: @user.items)
		# @orders = order_first.where("(order_status = ?) OR (order_status = ?)" ,3,4)
		#   @orders.each do |order|
		#   	order.price
		#   	#binding.pry
		#   end
		#   binding.pry

		##んん？
		#@orders = Order.where(item: @user.items)
		#@order_statuses = @orders.where("(order_status = ?) OR (order_status = ?) ", 0, 3)
		# @order = @order_statuses.each do |order|
		# 	order = Order.find_by(item: @user.items)
		# end
		# @orders = Order.where(item: @user.items, order_status: ["sales_request", "sales_request_done"])
		# @orders = Order.where(item: @user.items, order_status: "sales_request")
		# @price_sum = 0
		# @orders.each do |order|
		# 	@price_sum += order.price
		# end
		# @order = @orders.take
end



