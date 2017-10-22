class UsersController < ApplicationController

	def edit
    	@user = User.find(params[:id])
  	end

  	def update
  		@user = User.find(params[:id])
  		# @user.last_name  = params[:user][:last_name]
  		# @user.first_name = params[:user][:first_name]
  		# @user.email      = params[:user][:email]
  		if @user.update(user_params)
  			redirect_to "/"
  		else
  			redirect_to "/user/#{@user.id}/edit"
  		end
  	end

  	private

  	def user_params
  		params.require(:user).permit(:first_name, :last_name, :email)
  	end
end