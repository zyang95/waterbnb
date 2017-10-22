class Reservation < ApplicationRecord
	belongs_to :user
	belongs_to :listing

	validates :listing, uniqueness: { scope: :reservation_date,
    message: "there can be no two bookings on the same date" }
    
end
