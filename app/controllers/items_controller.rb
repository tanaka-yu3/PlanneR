class ItemsController < ApplicationController
  before_action :authenticate_user! , only:[:new , :create , :edit ,:update , :destroy]

  def index
    @latest_items = Item.order(create_at: "DESC").limit(3)
    @popular_items = Item.all.limit(3)
    @comingsoon_items = Item.where("(start_day > ?) AND (item_status != ?)",Date.today , 1).limit(3)
  end

  def show
    @item = Item.find(params[:id])
    @reviews = @item.reviews.all
  end

  def new
    @item = Item.new
    @item.photos.build
    @genres = Genre.all
  end

  def create
    @item = current_user.items.new(item_params)
    @item.photos.build
    url = params[:item][:video]
    url = url.last(11)
    @item.video = url
    @item.save
    redirect_to user_path(current_user)
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
    params.require(:item).permit(:user_id, :name, :genre_id, :text, :price, :video, :address, :start_day, :finish_day, :total ,:item_status, photos_images: [])
  end
end
