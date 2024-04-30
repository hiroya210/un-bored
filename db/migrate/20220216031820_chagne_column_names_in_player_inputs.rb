class ChagneColumnNamesInPlayerInputs < ActiveRecord::Migration[6.0]
  def change
    rename_column :player_inputs, :type, :input_type
    rename_column :player_inputs, :value, :input_value
  end
end
