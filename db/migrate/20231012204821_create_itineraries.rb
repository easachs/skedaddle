# frozen_string_literal: true

class CreateItineraries < ActiveRecord::Migration[7.0]
  def change
    create_table :itineraries do |t|
      t.string :search
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
