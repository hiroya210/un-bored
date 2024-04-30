class CreateGamesContents < ActiveRecord::Migration[6.0]
  def change
    create_table :games_contents do |t|
      t.text :content
      t.references :game, null: false, foreign_key: true
    end
  end
end
