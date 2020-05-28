class ItemsController < ApplicationController
  before_action :authenticate_user! , only:[:new , :create , :edit , :update , :destroy]
  before_action :item_custome , only:[:edit , :update , :destroy]

  def index
    @latest_items = Item.where(("item_status == ?") , 1).order(created_at: "DESC").limit(3)
    @popular_items = Item.where(("item_status == ?") , 1).sort_by {|item| item.orders.count }.reverse.slice(0,3)
    @comingsoon_items = Item.where("(start_day > ?) AND (item_status != ?)",Date.today , 1).limit(3)
  end

  ##新着商品
  def latest
    @items = Item.order(created_at: "DESC").page(params[:page]).per(5)
  end

  ##人気商品
  def popular
    @items = Item.where(("item_status == ?"),1).sort_by {|item| item.orders.count }.reverse.slice(0,5)
  end

  ##出品予定品
  def comming_soon
    @items = Item.where("(start_day > ?) AND (item_status != ?)",Date.today , 1).page(params[:page]).per(5)
  end

  def show
    @item = Item.find(params[:id])
    @review= Review.average(:rate)
    @reviews = @item.reviews.page(params[:page]).per(3)
    @items = Item.where("(genre_id == ?) AND (id != ?)" , @item.genre_id , @item.id).limit(3)
  end

  def new
    @item = Item.new
    @item.photos.build
    @genres = Genre.all
  end

  def create
    @item = current_user.items.new(item_params)
    #複数画像登録用
    @item.photos.build
    @item.photos.each do |photo|
      @item.photos.delete(photo) unless photo.valid?
    end
    #YOUTUBE URL取得用
    url = params[:item][:video]
    url = url.last(11)
    @item.video = url
    if @item.save
       flash[:item_save] = "新しいプランを作成しました!!承認までしばらくお待ちください"
       redirect_to user_path(current_user)
    else
      flash[:item_unsave] = "作成できませんでした。以下の項目を見直してください"
      @genres = Genre.all
      render :new
    end
  end

  ##URL直打ち防止
  def item_custome
    item = Item.find(params[:id])
    if current_user.id != item.user_id
      redirect_to items_path
    end
  end

  def edit
    @item = Item.find_by(id: params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
       flash[:update] = "変更しました!!"
       redirect_to item_path(@item)
    else
      redirect_to request.referer
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:user_id,
      :name,
      :genre_id,
      :text,
      :price,
      :video,
      :address,
      :start_day,
      :finish_day,
      :total,
      :item_status,
      photos_images: []
      )
  end
end
