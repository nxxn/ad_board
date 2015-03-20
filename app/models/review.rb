class Review < ActiveRecord::Base
  attr_accessible :from, :user_id, :positive

  belongs_to :user
end
