class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :instance, null: false, foreign_key: true
      t.references :voter, null: false
      t.references :voted_player, null: false

      t.timestamps
    end

    add_foreign_key :votes, :players, column: :voter_id
    add_foreign_key :votes, :players, column: :voted_player_id
  end
end
