class UsersController < ApplicationController
	
	def new
	end

	def create
		user = User.new(user_params)
		if user.save
			session[:user_id] = user.id
			flash[:notice] = "Your account was successfuly created"
			redirect_to '/posts'
		else 
			flash[:notice] = "Passwords did not match" 
  
			redirect_to '/'
		end
	end
	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
			
		end
	end

