class AddLatAndLonToBusinesses < ActiveRecord::Migration[7.1]
  def change
    add_column :businesses, :lat, :float
    add_column :businesses, :lon, :float
  end
end
