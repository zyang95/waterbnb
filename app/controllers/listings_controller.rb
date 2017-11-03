class ListingsController < ApplicationController
	def index
		if params[:search] && params[:start_date] && params[:end_date]
    		@listing = Listing.search_with_date(params[:search], params[:start_date], params[:end_date]).where(approval_status: true).order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
    	elsif params[:search]
    		@listing = Listing.search(params[:search]).where(approval_status: true).order("created_at DESC").paginate(:page => params[:page], :per_page => 8)
  		else  
			@listing = Listing.order("created_at DESC").where(approval_status: true).paginate(:page => params[:page], :per_page => 8)
		end
	end

	def new 
		@listing = Listing.new
		render template: "listings/new"
	end

	def create
		@listing = current_user.listings.new(listing_params)
		if @listing.save && @listing.valid?
			redirect_to "/listings"
		else
			render template: "listings/new"
		end
	end

	def show
		current_listing
		@reservation = @listing.reservations.new
	end

	def edit
		current_listing
	end

	def update
		current_listing
		if @listing.update(listing_params)
  		end
  			redirect_to "/listings/#{@listing.id}/edit"
	end

	def destroy
		current_listing.destroy
	end

	def approval
		if current_user.customer?
	        flash[:notice] = "Sorry. You are not allowed to perform this action."
	        return redirect_to current_user, notice: "Sorry. You do not have the permissino to verify a property."
      	else
      		current_listing
      		@listing.approval_status = true
      		@listing.save
      		redirect_to super_admin_path(current_user)
      		flash[:success] = "Listing have been approved."
      	end
	end

	private 
	def current_listing
		@listing = Listing.find(params[:id])
	end

	def listing_params
		params.require(:listing).permit(:accomodation_type, :capacity, :description, :listing_name, :address, :city, :country, :zipcode, :price, :place_type, {listing_images: []})
	end

end
