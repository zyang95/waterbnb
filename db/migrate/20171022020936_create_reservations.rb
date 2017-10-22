class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
    	t.references :user, foreign_key: true
    	t.references :listing, foreign_key: true
    	t.date 		 :reservation_date

		t.timestamps
    end
  end
end
