class CreateInstances < ActiveRecord::Migration[6.0]
  def change
    create_table :instances do |t|
      t.references :game, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :status
      t.integer :pin
    end
  end
end
