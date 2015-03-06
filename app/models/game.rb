class Game < ActiveRecord::Base
  attr_accessible :name, :genre_id

  belongs_to :genre
  has_many   :quest_types, dependent: :destroy
  has_many   :tasks
end
