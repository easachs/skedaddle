# frozen_string_literal: true

class CreatePlaces < ActiveRecord::Migration[7.0]
  def change
    create_table :places do |t|
      t.string :name
      t.string :address
      t.string :main
      t.references :itinerary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
