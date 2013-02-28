class CreateFavourites < ActiveRecord::Migration
  def change
    create_table :favourites do |t|
      t.integer :user_id
      t.string :venue_id

      t.timestamps
    end
  end
end
