class CreateRounds < ActiveRecord::Migration[6.0]
  def change
    create_table :rounds do |t|
      t.integer :number, default: 0, null:false
      t.references :game_content, null: false, foreign_key: true
    end
  end
end
