class ReviewsController < ApplicationController
  def index
    @reviews = current_user.reviews.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.save
    redirect_to reviews_path
  end

  private

  def review_params
    params.require(:review).permit(:text)
  end
end
