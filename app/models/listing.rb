class Listing < ApplicationRecord
	belongs_to :user
	has_many :reservations, dependent: :destroy
	mount_uploaders :listing_images, ListingImagesUploader
	validates :capacity, numericality: { greater_than: 0 }
	validates :price, numericality: { greater_than: 0 }
	validates :address, :city, :country, :zipcode, :accomodation_type, :place_type, :listing_name, :description, :presence => true

	filterrific(
	  default_filter_params: { sorted_by: 'created_at_desc' },
	  available_filters: [
	    :sorted_by,
	    :search_query,
	    :with_country_id,
	    :with_created_at_gte
	  ]
	)

	def self.search(search)
	  search.downcase!
	  Listing.where("lower(city) LIKE ? OR lower(listing_name) LIKE ?", "%#{search}%", "%#{search}%")
	end

	def self.search_with_date(search, start_date, end_date)
		search.downcase!
	  	Listing.joins(:reservations)
	  		.where("lower(city) LIKE ? OR lower(listing_name) LIKE ?", "%#{search}%", "%#{search}%")
	  		.where.not("reservations.start_date < ? AND ? <= reservations.end_date", start_date, start_date)
	  		.where.not("reservations.start_date <= ? AND ? < reservations.end_date", end_date, end_date)

	  	# {listing1, listing2}.reservation
	  	# listing.reservation
	  	# Listing.joins(:reservations).where('reservations.start_date ?')

	  	# output.map do |lsting|
	  	# 	lsting.reservations
	  	# 		.where.not("start_date < ? AND ? <= end_date", start_date, start_date)
	  	# 		.where.not("start_date <= ? AND ? < end_date", end_date, end_date)
	  	# 		.map { |x| x.listing }
	  	# end
	  	# Relation{listing1,listing2,...}
	  	# [Relations1{listing1, listing2,}, Relations2, ...]
	  	# [[listing, listing, ...], [listing]]
	  	# [listing, listing]
	  	# byebug

	  	#output.select {|x| x.reservation_check(start_date, end_date)}
	end

	# def reservation_check(start_date, end_date)

	# 	@dates = Reservation.all.where(listing_id: self.id).where(payment_status: true)
	# 	@start_date = Date.parse(start_date)
	# 	@end_date = Date.parse(end_date)
		
 #        @dates.detect do |t|
 # 			(t.start_date < @start_date  && @start_date <= t.end_date) && (t.start_date <= @end_date && @end_date < t.end_date) 
 #        end.nil?
	# end
end






