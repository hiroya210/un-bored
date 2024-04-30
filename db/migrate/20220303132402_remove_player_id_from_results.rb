class RemovePlayerIdFromResults < ActiveRecord::Migration[6.0]
  def change
    remove_reference :results, :player, foreign_key: true, index: false
    remove_column :results, :yes_count, :integer
    remove_column :results, :no_count, :integer
    add_column :results, :most_yes_player_id, :integer
    add_column :results, :most_no_player_id, :integer
    add_column :results, :most_voted_player_id, :integer
  end
end
