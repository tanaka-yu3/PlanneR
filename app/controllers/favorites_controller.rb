class FavoritesController < ApplicationController
  before_action :authenticate_user!, only:[:create, :destroy]

  def index
    @user = User.find(params[:user_id])
    @favorites = @user.favorites.page(params[:page]).per(5)
  end

  def create
  	@item = Item.find(params[:item_id])
  	favorite = @item.favorites.new(user_id: current_user.id)
  	if favorite.save
      flash[:favorite]= "お気に入り登録しました!!"
  	  redirect_to request.referer
    end
  end

  def destroy
  	@item = Item.find(params[:id])
  	favorite = @item.favorites.find_by(user_id: current_user.id)
  	favorite.destroy
  	redirect_to request.referer
  end
end
