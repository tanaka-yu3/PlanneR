class Admins::ItemsController < ApplicationController
	before_action :authenticate_admin!

	def index
		@items = Item.where(item_status: 0).page(params[:page]).per(5)
		@destroy_items = Item.where("(finish_day < ?) AND (item_status = ?)", Date.today, 1 ).page(params[:page]).per(5)
	end

	def show
		@item = Item.find(params[:id])
	end

	def update
		@item = Item.find(params[:id])
		@item.item_status = params[:item][:item_status]
		if @item.save
			if Item.find_by(id: @item.id + 1)
			   redirect_to admins_item_path(@item.id + 1)
			else
			   redirect_to admins_items_path
			end
		else
			redirect_to request.referer
		end
	end
end