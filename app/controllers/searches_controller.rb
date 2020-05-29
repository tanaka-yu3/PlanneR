class SearchesController < ApplicationController

	def search
		@model = params["search"]["model"]
		@content = params["search"]["content"]
		@method = params["search"]["method"]
		@records = search_for(@model,@content,@method).all
	end

	private

	def search_for(model,content,method)
		if @model == 'user'
		   method == 'partial'
		   User.where('family_name LIKE ?', '%'+content+'%')
	    else
	       @model == 'item'
		   method == 'partial'
		   Item.where('name LIKE ?', '%'+content+'%')
		end
	end
end
