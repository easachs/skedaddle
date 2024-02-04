class AddCreditToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :credit, :integer, default: 10
  end
end
