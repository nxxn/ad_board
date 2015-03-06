class AddGameIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :game_id, :integer
    add_column :tasks, :quest_type_id, :integer
  end
end
