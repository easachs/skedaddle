# frozen_string_literal: true

class CreateItineraries < ActiveRecord::Migration[7.0]
  def change
    create_table :itineraries do |t|
      t.string :label
      t.string :locality
      t.string :region
      t.string :country
      t.float :lat
      t.float :lon
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
