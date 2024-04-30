class AddImpostorToInstance < ActiveRecord::Migration[6.0]
  def change
    remove_column :players, :imposter, :boolean
    add_reference :instances, :impostor, foreign_key: { to_table: :players }
  end
end
