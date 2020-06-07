class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :genre, limit: 20, null: false
      t.string :title, limit: 20, null: false
      t.string :memo, limit: 200, null: false

      t.timestamps
    end
  end
end
