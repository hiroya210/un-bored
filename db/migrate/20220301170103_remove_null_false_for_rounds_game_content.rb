class RemoveNullFalseForRoundsGameContent < ActiveRecord::Migration[6.0]
  def change
    # so we can have a null value for game_content on round zero
    change_column_null(:rounds, :game_content_id, true)
  end
end
