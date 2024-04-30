class AddRoundsReferenceToPlayerInputs < ActiveRecord::Migration[6.0]
  def change
    add_reference :player_inputs, :round, foreign_key: true
  end
end
