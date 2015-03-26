class AddWorkerAndFinalPriceToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :worker_id, :integer
    add_column :tasks, :final_price, :float, default: 0
    add_column :tasks, :payment_status, :string, default: "not paid"
  end
end
