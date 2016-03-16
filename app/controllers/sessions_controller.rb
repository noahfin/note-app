class SessionsController < ApplicationController
	def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      flash[:notice] = "You are now login"
      redirect_to '/posts'
    else
    # If user's login doesn't work, send them back to the login form.
     flash[:notice] = 'Invalid email/password combination'
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are now logout"
    redirect_to '/login'
  end
end
