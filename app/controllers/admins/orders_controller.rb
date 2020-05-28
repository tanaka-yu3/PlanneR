class Admins::OrdersController < ApplicationController
	before_action :authenticate_admin!

	def index
		#@orders = Order.order(:id)
		@orders = Order.page(params[:page]).per(5)
	end

	def update
		order = Order.find(params[:id])
		if order_status = 0
		  order.update(order_status: 1)
		elsif order_status = 3
		  order.update(order_status: 4)
		else
		  order.update(order_status: 5)
		end
		  flash[:complete_payment] ="支払い完了ステータスに変更しました"
		  redirect_to request.referer
		# else
	 #    orders = Order.where("(order_status = ? ) OR (order_status = ? )", 3 , 4 )
		# 	orders.each do |order|
		# 		if order_status = 3
		# 		  order.update(order_status: "sales_request_done")
		# 	    else order_status = 4
		# 	      order.update(order_status: "transfer_complete" )
		# 	    end
		# 	end
		#   redirect_to request.referer
		#end
		
		# @orders = Order.where("order_status = ? ",3)
		# @orders.each do |order|
		# 	if order_status = 3
		# 	order.update(order_status: 4)
		#     else
		#     order.update(order_status: 5)
		#     end
		# flash[:supply_comfirm] ="申請を受理しました"
		#
	end
end

