class ReservationsController < ApplicationController
	def index
	
	end

	def new
		@reservation = Reservation.new(reservation_params)
		@listing = @reservation.listing
		@duration = (@reservation.end_date - @reservation.start_date).to_i
		@reservation.user_id = current_user.id
		if @reservation.valid? && @reservation.date_capacity_checker
			render template: "reservations/new"
		else
			redirect_to listing_path(@reservation.listing.id)
			@error = "Please select a valid field"
		end
	end
	
	def create
		@reservation = Reservation.new(reservation_params)
		@reservation.user_id = current_user.id
		if @reservation.save
			redirect_to paypal_form_path(@reservation)
		else
			render template: "reservations/new"
		end
	end

	def destroy
		@reservation.destroy
	end

	def paypal
  		@client_token = Braintree::ClientToken.generate
	end

	def paypal_checkout
	  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]

	  result = Braintree::Transaction.sale(
	   :amount => params[:checkout_form][:ammount], #this is currently hardcoded
	   :payment_method_nonce => nonce_from_the_client,
	   :options => {
	      :submit_for_settlement => true
	    }
	   )

	  if result.success?
	    redirect_to user_path(current_user), :flash => { :success => "Transaction successful!" }
	    reservation_number = params[:checkout_form][:reservation]
	    reservation = Reservation.find(reservation_number)
	    reservation.payment_status = true
	    reservation.save
	    user = reservation.user
	    host = reservation.listing.user
	    listing = reservation.listing
	    ReservationJob.perform_later(user, host, listing)
	    # ReservationMailer.booking_email(user, host, listing).deliver_later
	  else
	    redirect_to user_path(current_user), :flash => { :error => "Transaction failed. Please try again." }
	  end
	end

	private

	def reservation_params
		params.require(:reservation).permit(:start_date, :end_date, :number_of_guests, :listing_id)
	end
end
