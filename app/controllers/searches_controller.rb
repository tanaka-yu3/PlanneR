class SearchesController < ApplicationController

	def search
		@model = params["search"]["model"]
		@content = params["search"]["content"]
		@method = params["search"]["method"]
		@records = search_for(@model,@content,@method).all
	end

	private

	def search_for(model,content,method)
		if @model == "user"
		   method == "partial"
		   User.where("family_name LIKE ?", "%"+content+"%")
	    elsif @model == "item"
		   method == "partial"
		   Item.where("name LIKE ?", "%"+content+"%")
		else
			method == "partial"
		    Order.where("id LIKE ?", "%"+content+"%")
		end
	end
end
