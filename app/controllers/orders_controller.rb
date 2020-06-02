class OrdersController < ApplicationController
	before_action :authenticate_user!,except: [:index]

	def index
		@user = User.find(params[:user_id])
		@orders = @user.orders.order(created_at: "desc").page(params[:page]).per(5)
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

	##売上金申請画面用
	def sales_request
		@user = User.find(params[:user_id])
		##口座登録が完了しているかチェック
		bank = @user.bank_name && @user.bank_account_kind && @user.bank_branch_code && @user.bank_account_number
		  if bank.present?
		  	@order = Order.where(item: @user.items)
			@orders = @order.where("order_status = ?" ,2)
			@order_status = @orders.each do |order|
			  order = @orders.find_by(id: order.id)
		    end
		  else
		  	redirect_to user_path(@user)
		  	flash[:bank_check] = "口座情報の登録を実施してください"
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
