class Listing < ApplicationRecord
	belongs_to :user
	has_many :reservations, dependent: :destroy
	mount_uploaders :listing_images, ListingImagesUploader
	validates :capacity, numericality: { greater_than: 0 }
	validates :price, numericality: { greater_than: 0 }

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

end
