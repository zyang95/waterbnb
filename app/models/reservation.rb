class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :listing

	validates :listing, uniqueness: { scope: :start_date, message: "there can be no two bookings on the same date" }
    validates :start_date, 		 presence: true
    validates :end_date, 		 presence: true
    validates :number_of_guests, presence: true

    def self.validate(reservation)
    	@dates = Reservation.all
    	@capacity = Listing.find(reservation.listing_id).capacity
    	@dates.each do |t|
    		if (t.start_date < reservation.start_date  && reservation.start_date <= t.end_date) && 
    			(t.start_date <= reservation.end_date && reservation.end_date < t.end_date) &&
    			reservation.number_of_guests < @capacity
    			return false
    		else
    			return true
    		end
    	end
    end

end
