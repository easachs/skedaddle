# frozen_string_literal: true

class CreateHospitals < ActiveRecord::Migration[7.0]
  def change
    create_table :hospitals do |t|
      t.string :name
      t.string :address
      t.references :itinerary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
