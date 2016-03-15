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
			flash[:notice] = user.errors.full_messages[0]
			# flash[:notice] = "Passwords did not match" 
  
			redirect_to '/'
		end
	end
	def update

    if current_user   
	    @user = User.find(current_user.id)
	    if @user.update_attributes(user_params)
	      flash[:notice] = "Your account was successfully updated "
	      redirect_to "/posts"
	    else
	       flash[:notice] = "Error: Please enter a password"
	       redirect_to(:back)
	     end
	    else
	    	flash[:notice] = "You need to signin first"
	    	redirect_to(:back)
	   end
	end
	private
		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation)
			
		end
	end

