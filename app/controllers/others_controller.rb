class OthersController < ApplicationController

	def top
		@items = Item.page(params[:page]).per(3)
	end

    def about
    end

    def inquiry
    end
end
