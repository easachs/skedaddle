# frozen_string_literal: true

class CreateParks < ActiveRecord::Migration[7.0]
  def change
    create_table :parks do |t|
      t.string :name
      t.string :location
      t.string :description
      t.string :directions
      t.string :activities
      t.string :url
      t.string :thumbnail
      t.references :itinerary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
