class AddCheckpostToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :status, :integer,null: false, default: 0
  end
end
