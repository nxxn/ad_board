class AdddOffersCountToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :offers_count, :integer, default: 0
  end
end
