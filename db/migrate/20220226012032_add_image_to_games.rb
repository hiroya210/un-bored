class AddImageToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :image, :string
  end
end
