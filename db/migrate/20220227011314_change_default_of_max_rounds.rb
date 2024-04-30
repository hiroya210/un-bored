class ChangeDefaultOfMaxRounds < ActiveRecord::Migration[6.0]
  def change
    change_column_null :instances, :max_rounds, false
    change_column_default :instances, :max_rounds, from: 1, to: 5
  end
end
