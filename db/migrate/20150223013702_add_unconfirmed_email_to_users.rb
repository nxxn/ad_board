class AddUnconfirmedEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unconfirmed_email, :string, default: ""
    add_column :users, :is_admin, :boolean, default: false
  end
end
