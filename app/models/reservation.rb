class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :listing

    validates :start_date, 		 presence: true
    validates :end_date, 		 presence: true
    validates :number_of_guests, presence: true

    def date_capacity_checker
    	@dates = Reservation.all.where(listing_id: self.listing_id).where(payment_status: true)
    	@capacity = Listing.find(self.listing_id).capacity
    	@dates.each do |t|
    		if (t.start_date < self.start_date  && self.start_date <= t.end_date) && 
    			(t.start_date <= self.end_date && self.end_date < t.end_date) &&
    			self.number_of_guests < @capacity
    			return false
            end
    	end
        return true
    end

    def check_payment_status
        return false if self.payment_status == true
    end

    validate :check_payment_status, on: [:create, :update]

end
