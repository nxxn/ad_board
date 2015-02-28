class Task < ActiveRecord::Base
  attr_accessible :user_id, :name, :description, :estimated_price, :term, :active

  belongs_to :user
  has_many :offers, dependent: :destroy
  has_many :jobs, dependent: :destroy
end
