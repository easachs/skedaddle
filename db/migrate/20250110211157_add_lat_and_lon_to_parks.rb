class AddLatAndLonToParks < ActiveRecord::Migration[7.1]
  def change
    add_column :parks, :lat, :float
    add_column :parks, :lon, :float
  end
end
