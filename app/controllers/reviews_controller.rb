class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = User.find(params[:user_id])
    @reviews = @user.reviews.all
  end

  def reviewed
    @user = User.find(params[:user_id])
    @reviews = Review.where(item: @user.items)
  end

  def show
    @item = Item.find(params[:id])
    @review = @item.reviews.find(params[:id])
  end

  def new
    @item = Item.find(params[:item_id])
    @review = @item.reviews.new
  end

  def create
    @item = Item.find(params[:item_id])
    @review = @item.reviews.new(review_params)
    @review.user_id = current_user.id
    @review.save
    flash[:review_save] = "レビューを登録しました！！"
    redirect_to item_path(@item)
  end

  private

  def review_params
    params.require(:review).permit(:user_id, :item_id, :text ,:rate, photos_images:[])
  end
end
