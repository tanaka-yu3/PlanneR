class Admins::GenresController < ApplicationController
	before_action :authenticate_admin!

	def index
		@genre = Genre.new
		@genres = Genre.page(params[:page]).per(10)
	end

	def create
		@genre =Genre.new(genre_params)
		if @genre.save
			flash[:save] = "作成完了しました!!"
			redirect_to request.referer
		else
			flash[:unsave] = "作成できませんでした。"
			redirect_to request.referer
		end
	end

	def destroy
		@genre = Genre.find(params[:id])
		@genre.destroy
		redirect_to request.referer
	end

	private

	def genre_params
		params.require(:genre).permit(:name)
	end
end

