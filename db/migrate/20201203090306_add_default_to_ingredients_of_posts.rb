class AddDefaultToIngredientsOfPosts < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :ingredients, :string, limit: 200, null: false, default: "・ \n・ \n・ \n・ \n・"
  end
end
