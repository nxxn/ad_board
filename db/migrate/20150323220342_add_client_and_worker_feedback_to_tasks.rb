class AddClientAndWorkerFeedbackToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :client_feedback, :boolean, default: false
    add_column :tasks, :worker_feedback, :boolean, default: false
  end
end
