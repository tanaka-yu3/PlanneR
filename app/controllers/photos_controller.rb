class PhotosController < ApplicationController
	def create
		photo = Photo.new(photo_params)
		photo.save
	end

	private
	def photo_params
		params.reqiure(:photo).permit(:image ,:user_id , :review_id)
	end
end
