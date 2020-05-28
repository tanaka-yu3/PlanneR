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
    @order = @item.orders.find_by("(order_status = ?) AND (item_id = ?)", 1 , @item.id)
  end

  def create
    @item = Item.find(params[:item_id])
    @review = @item.reviews.new(review_params)
    @review.user_id = current_user.id
    @order = Order.find(params[:order_id])
    if @review.save
       flash[:review_save] = "レビューを登録しました！！"
      
       @order.update(order_status: 2)
       redirect_to item_path(@item)
    else
      flash[:review_unsave] = "レビューが投稿できませんでした"
      @item = Item.find(params[:item_id])
      @review = @item.reviews.new(review_params)
      @review.user_id = current_user.id
      @order = Order.find(params[:order_id])
      render :new
    end

  end

  private

  def review_params
    params.require(:review).permit(:user_id, :item_id, :text ,:rate)
  end
end
