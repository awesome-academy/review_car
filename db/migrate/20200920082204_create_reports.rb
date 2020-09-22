class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.string :content
      t.integer :user_id, foreign_key: true
      t.integer :post_id, foreign_key: true

      t.timestamps
    end
  end
end
