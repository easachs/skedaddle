# frozen_string_literal: true

class CreateAirports < ActiveRecord::Migration[7.0]
  def change
    create_table :airports do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.references :itinerary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
