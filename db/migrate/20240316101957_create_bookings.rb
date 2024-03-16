class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.references :user, null: false, foreign_key: true
      t.references :listing, null: false, foreign_key: true
      t.integer :total

      t.timestamps
    end
  end
end
