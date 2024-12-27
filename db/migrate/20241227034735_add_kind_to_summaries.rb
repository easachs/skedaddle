class AddKindToSummaries < ActiveRecord::Migration[7.1]
  def change
    add_column :summaries, :kind, :integer, null: false, default: 0
  end
end
