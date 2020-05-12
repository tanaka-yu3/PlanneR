class ItemsController < ApplicationController
  def about
  end

  def inquiry
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @reviews = @item.reviews.all
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = current_user.items.new(item_params)
    @item.photos.build
    @item.save
    redirect_to @item
  end

  def edit
    @item = Item.find_by(id: params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to item_path(@item)
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:user_id, :name, :genre_id, :text, :price, :video, :address, :start_day, :finish_day, :total , photos_images:[])
  end
end
