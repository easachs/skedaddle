class DropKeys < ActiveRecord::Migration[7.1]
  def change
    drop_table :keys
  end
end
