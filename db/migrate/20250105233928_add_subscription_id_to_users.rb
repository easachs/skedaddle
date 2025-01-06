class AddSubscriptionIdToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :subscription_id, :string
    add_column :users, :canceled, :boolean, default: false, null: false
  end
end
