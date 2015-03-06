class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :max_offers_count_for_quest

  def max_offers_count_for_quest
    @max_offers_count_for_quest = Setting.get_value("max_offers_count_for_quest").to_i
  end

  def authenticate_admin_user!
    redirect_to new_user_session_path unless current_user.is_admin
  end
end
