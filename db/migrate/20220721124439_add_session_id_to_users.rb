class AddSessionIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :session_id, :string
  end
end