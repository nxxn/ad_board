class AddInProgressToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :status, :string, default: "created"
  end
end
