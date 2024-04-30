class CreateResults < ActiveRecord::Migration[6.0]
  def change
    create_table :results do |t|
      t.references :player, null: false, foreign_key: true
      t.references :instance, null: false, foreign_key: true
      t.integer :yes_count
      t.integer :no_count

      t.timestamps
    end
  end
end
