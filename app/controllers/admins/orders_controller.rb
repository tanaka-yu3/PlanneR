class Admins::OrdersController < ApplicationController
	before_action :authenticate_admin!

	def index
		@orders = Order.page(params[:page]).per(5)
	end

	def update
		order = Order.find(params[:id])
		order.update(order_status: 1)
		flash[:complete_payment] ="支払い完了ステータスに変更しました"
		redirect_to request.referer
	end
end

