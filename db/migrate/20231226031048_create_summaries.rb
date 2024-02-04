class CreateSummaries < ActiveRecord::Migration[7.0]
  def change
    create_table :summaries do |t|
      t.text :response
      t.references :itinerary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
