class Columnforlistingstableboleon < ActiveRecord::Migration[5.1]
  def change
  	add_column :listings, :approval_status, :boolean, default: false
  end
end
