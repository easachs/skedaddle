class AddFavoritedToBusinesses < ActiveRecord::Migration[7.1]
  def change
    add_column :businesses, :favorited, :boolean, default: false
  end
end
