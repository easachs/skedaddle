class AddDatesToItinerary < ActiveRecord::Migration[7.0]
  def change
    add_column :itineraries, :start_date, :string
    add_column :itineraries, :end_date, :string
  end
end
