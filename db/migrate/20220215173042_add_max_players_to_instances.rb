class AddMaxPlayersToInstances < ActiveRecord::Migration[6.0]
  def change
    add_column :instances, :max_players, :integer, default: 5, null: false
  end
end
