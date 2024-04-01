class AddDescriptionColumnToListings < ActiveRecord::Migration[7.1]
  def change
    add_column :listings, :description, :text
  end
end
