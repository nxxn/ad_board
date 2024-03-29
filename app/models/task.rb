class Task < ActiveRecord::Base
  attr_accessible :user_id, :name, :description, :estimated_price, :term, :active, :game_id, :play_method_ids, :quest_type_id, :status, :worker_id, :payment_status, :final_price, :client_feedback, :worker_feedback, :offers_count

  belongs_to :user
  belongs_to :game
  belongs_to :quest_type
  belongs_to :worker, :class_name => "User"

  has_many :offers, dependent: :destroy
  has_one :job, dependent: :destroy

  has_and_belongs_to_many :play_methods

  accepts_nested_attributes_for :play_methods, allow_destroy: true

end
