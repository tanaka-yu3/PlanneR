class Admins::GenresController < ApplicationController
	before_action :authenticate_admin!

	def index
		@genre = Genre.new
		@genres = Genre.all
	end

	def create
		@genre =Genre.new(genre_params)
		@genre.save
		redirect_to request.referer
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
