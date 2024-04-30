class ChangeImpostorToImpostorPlayerInInstances < ActiveRecord::Migration[6.0]
  def change
    rename_column :instances, :impostor_id, :impostor_player_id
  end
end
