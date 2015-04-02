class CreateMoneyOrders < ActiveRecord::Migration
  def change
    create_table :money_orders do |t|
      t.float   :amount
      t.integer :user_id
      t.string  :payment_status
      t.integer :task_id
      t.string  :invoice

      t.timestamps
    end
  end
end
