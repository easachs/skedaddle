# frozen_string_literal: true

class CreateBusinesses < ActiveRecord::Migration[7.0]
  def change
    create_table :businesses do |t|
      t.string :name
      t.string :rating
      t.string :price
      t.string :categories
      t.string :location
      t.string :phone
      t.string :url
      t.string :thumbnail
      t.references :itinerary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
