class Setting < ActiveRecord::Base
  attr_accessible :key, :value, :description

  validates :key, :value, :presence => true
  validates :key, uniqueness: true

  class << self

    def get_value(key)
      setting = Setting.where(key: key).first
      setting.value
    end

  end
end
