# frozen_string_literal: true

class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :rating
      t.string :price
      t.string :categories
      t.string :address
      t.string :phone
      t.string :url
      t.string :thumbnail
      t.references :itinerary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
