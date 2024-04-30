class ChangePinToPassCodeInInstances < ActiveRecord::Migration[6.0]
  def change
    rename_column :instances, :pin, :passcode
    change_column :instances, :passcode, :string, null: false
  end
end
