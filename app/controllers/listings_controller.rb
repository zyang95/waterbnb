class ListingsController < ApplicationController
	def index
		@listing = Listing.where(user_id: current_user)
	end

	def new 
		@listing = Listing.new
		render template: "listings/new"
	end

	def create
		
		@listing = current_user.listings.new(listing_params)
		if @listing.save
			redirect_to "/listings"
		else
			render template: "listings/new"
		end
	end

	def show
		@listing = Listing.find(params[:id])
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		if @listing.update(listing_params)
  			redirect_to "/listings/#{@listing.id}"
  		else
  			redirect_to "/listings/#{@listing.id}/edit"
  		end
	end

	private 

	def listing_params
		params.require(:listing).permit(:accomodation_type, :capacity, :description, :listing_name, :address, :city, :country, :zipcode, :price, :place_type)
	end

end
