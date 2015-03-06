class Offer < ActiveRecord::Base
  attr_accessible :user_id, :task_id, :status, :client_price, :worker_price, :comment, :client_times, :worker_times

  belongs_to :user
  belongs_to :task
end
