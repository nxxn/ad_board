class Review < ActiveRecord::Base
  attr_accessible :from, :user_id, :task_id, :positive, :negaative, :task_id, :comment

  belongs_to :user
  belongs_to :author, :class_name => "User", :foreign_key => "from"
  belongs_to :task
end
