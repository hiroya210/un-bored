class AddDefaultValueToInstanceStatus < ActiveRecord::Migration[6.0]
  def change
    # update column to have null: false
    change_column_null :instances, :status, false
    # update column to have default value for status as "waiting"
    change_column_default :instances, :status, "waiting"
  end
end
