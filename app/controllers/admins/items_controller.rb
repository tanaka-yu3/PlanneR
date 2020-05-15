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
		@item.update(params.require(:item).permit(:item_status))
		redirect_to admins_items_path
	end
end