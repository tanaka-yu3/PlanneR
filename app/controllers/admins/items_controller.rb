class Admins::ItemsController < ApplicationController
	before_action :authenticate_admin!
	
	def index
		@items = Item.all
	end
end
