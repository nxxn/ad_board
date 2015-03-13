class AddApprovedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :approved, :boolean, default: true
  end
end
