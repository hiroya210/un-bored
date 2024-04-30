class CreatePlayerInputs < ActiveRecord::Migration[6.0]
  def change
    create_table :player_inputs do |t|
      t.references :player, null: false, foreign_key: true
      t.references :instance, null: false, foreign_key: true
      t.string :type
      t.text :value
    end
  end
end
