class AddTaskToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :task_id, :integer
    add_column :reviews, :comment, :text, default: ""
  end
end
