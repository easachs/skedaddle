class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :payment_id, null: false
      t.integer :amount, null: false
      t.string :payment_type, null: false

      t.timestamps
    end
  end
end
