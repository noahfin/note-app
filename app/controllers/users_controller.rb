class UsersController < ApplicationController
	
	def new
	end

	def create


		respond_to do |format|
      if @user = User.create(user_params)
        format.html { redirect_to '/posts', notice: "Your account was successfuly created" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :wlcome }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

	end

private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)

	end
end
