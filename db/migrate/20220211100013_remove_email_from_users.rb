class RemoveEmailFromUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :email, :string, null: true
    remove_index "users", name: "index_users_on_email"
  end
end
