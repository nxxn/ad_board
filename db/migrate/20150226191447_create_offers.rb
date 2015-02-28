class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.integer  :user_id
      t.integer  :task_id
      t.string   :status, default: ""
      t.float    :client_price, default: 0
      t.float    :worker_price, default: 0
      t.text     :comment, default: ""
      t.integer  :client_times, default: 0
      t.integer  :worker_times, default: 0

      t.timestamps
    end
  end
end
