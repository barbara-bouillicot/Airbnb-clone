class CreateListings < ActiveRecord::Migration[7.1]
  def change
    create_table :listings do |t|
      t.string :name
      t.string :address
      t.date :availability_from
      t.date :availability_to
      t.integer :maximum_pets
      t.string :home_type
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
