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
		@order.user_id = current_user.id
		unless @order.valid?
		  render :new
		end
	end

	def sales_request
		@user = User.find(params[:user_id])
		@order = Order.where(item: @user.items)
		@orders = @order.where("order_status = ?" ,2 )
		@order_status = @orders.each do |order|
			order = @orders.find_by(id: order.id)
		end
	end

	##オーダーステータスレビューと同時更新用
	def sales_request_finish
		@user = User.find(params[:user_id])
		@order = Order.where(item: @user.items)
		@orders = @order.where("order_status = ?" ,2 )
		@orders.each do |order|
			order.update(order_status: 3)
		end
		flash[:order_status_update] = "売上金申請をしました"
		redirect_to user_path(current_user)
	end


	def create
		@item = Item.find(params[:item_id])
		@order = @item.orders.new(order_params)
		@order.user_id = current_user.id
		@order.price = @item.price*@order.amount
		if @order.save
		   redirect_to item_thanks_path
		else
			flash[:order_unsave] = "注文を確定できませんでした。注文内容をもう一度ご確認ください。"
			render :new
		end
	end

	def thanks
	end

	private

	def order_params
		params.require(:order).permit(:user_id, :item_id, :first_day, :last_day, :amount ,:pay)
	end
end
