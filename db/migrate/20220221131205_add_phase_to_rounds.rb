class AddPhaseToRounds < ActiveRecord::Migration[6.0]
  def change
    add_column :rounds, :phase, :integer, default: 1
  end
end
