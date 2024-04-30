class AddInstanceReferenceToRounds < ActiveRecord::Migration[6.0]
  def change
    add_reference :rounds, :instance, foreign_key: true
  end
end
