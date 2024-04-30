class ChangeGamesContentsToGameContents < ActiveRecord::Migration[6.0]
  def change
    rename_table :games_contents, :game_contents
  end
end
