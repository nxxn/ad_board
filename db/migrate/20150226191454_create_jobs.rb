class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer  :user_id
      t.integer  :task_id
      t.string   :status, default: ""
      t.float    :price, default: 0
      t.string   :term, default: ""
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps
    end
  end
end
