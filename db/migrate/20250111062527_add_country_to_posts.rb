class AddCountryToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :country, :string
  end
end
