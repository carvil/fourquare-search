class AddMoreFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :last_name, :string
  end
end
