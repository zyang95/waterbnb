class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
    	t.references :user, foreign_key: true
    	t.references :listing, foreign_key: true
    	t.date 		 :start_date
    	t.date       :end_date
    	t.integer 	 :number_of_guests

		t.timestamps
    end
  end
end
