class CreatePlayMethodsAndTasks < ActiveRecord::Migration
  def change
    create_table :play_methods_tasks, id: false do |t|
      t.belongs_to :play_method, index: true
      t.belongs_to :task, index: true
    end
  end
end
