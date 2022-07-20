class AddRequestTokenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :request_token, :string
  end
end
