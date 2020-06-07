class AddIngredientsToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :ingredients, :string, limit: 200, null: false
  end
end
