class HomeController < ApplicationController
	def index
		if 	current_user	
			@posts = Post.where(:user_id => current_user.id)
			@post = Post.new
			render :index
		else
			flash[:notice] = "You need to login first"
			redirect_to '/login'
		end
		
	end
end
