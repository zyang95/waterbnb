class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.references :user, foreign_key: true
      t.string     :address, null:false
      t.string     :city, null:false
      t.string     :country, null:false
      t.string     :zipcode, null:false 
      t.integer    :price, null:false
      t.string     :accomodation_type, null:false
      t.integer    :capacity, null:false
      t.string     :description
      t.string     :listing_name, null:false
      t.string     :place_type, null:false

      t.timestamps
    end
  end
end
