class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		
		# @user.last_name  = params[:user][:last_name]
		# @user.first_name = params[:user][:first_name]
		# @user.email      = params[:user][:email]
		@user = User.find(params[:id])
		if @user.update(user_params)

			redirect_to @user #redirect_to user object will automatically goes to the user_path of that object
		else
			redirect_to edit_user_path
		end

	end


	def listings
		@user = User.find(params[:id])
		@listings = @user.listings
	end

	def super_admin
		@listing = Listing.order("created_at DESC").where(approval_status: false).paginate(:page => params[:page], :per_page => 8)
	end

	def reservations
		@reservation = Reservation.where(user_id: current_user).where(payment_status: true)
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :email, :profile)
	end
end