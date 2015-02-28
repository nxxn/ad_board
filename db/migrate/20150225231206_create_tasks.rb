class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer  :user_id
      t.string   :name, default: ""
      t.text     :description, default: ""
      t.float    :estimated_price, default: 0
      t.string   :term, default: ""
      t.boolean  :active, default: true

      t.timestamps
    end
  end
end
