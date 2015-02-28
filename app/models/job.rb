class Job < ActiveRecord::Base
  attr_accessible :user_id, :task_id, :status, :price, :term, :started_at, :ended_at

  belongs_to :user
  belongs_to :task
end
