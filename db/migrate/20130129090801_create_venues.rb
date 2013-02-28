class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues, id: false do |t|
      t.string :venue_id, primary: true
      t.string :canonical_url
      t.string :name
      t.string :categories
      t.string :address
      t.string :city
      t.string :country
      t.string :distance
    end
  end
end
