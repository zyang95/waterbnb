class ReservationsController < ApplicationController

	def new
		@reservation = Reservation.new
		render template: "reservations/new"
	end

end
