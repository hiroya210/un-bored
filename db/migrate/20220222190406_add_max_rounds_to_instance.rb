class AddMaxRoundsToInstance < ActiveRecord::Migration[6.0]
  def change
    add_column :instances, :max_rounds, :integer, default: 1
  end
end
