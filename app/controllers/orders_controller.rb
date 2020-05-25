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

	def pay
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      :amount => params[:amount],
      :card => params['payjp-token'],
      :currency => 'jpy')
  end

	def thanks
	end

	private

	def order_params
		params.require(:order).permit(:user_id, :item_id, :first_day, :last_day, :amount)
	end
end
