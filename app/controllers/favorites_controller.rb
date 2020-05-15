class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
  	@item = Item.find(params[:item_id])
  	favorite = @item.favorites.new(user_id: current_user.id)
  	favorite.save
  	redirect_to request.referer
  end

  def destroy
  	@item = Item.find(params[:id])
  	favorite = @item.favorites.find_by(user_id: current_user.id)
  	favorite.destroy
  	redirect_to request.referer
  end
end
