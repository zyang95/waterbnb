class AddListingImagesToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :listings, :listing_images, :json
  end
end
