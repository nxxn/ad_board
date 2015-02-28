class HomeController < ApplicationController

  def index
    @tasks = Task.where(active: true).includes(:user)

    @task = Task.new

    @offer = Offer.new
  end

end
