class HomeController < ApplicationController

  def index
    @tasks = Task.where(active: true).includes(:user, :game, :quest_type, :play_methods)

    @task = Task.new
    @offer = Offer.new

    @games = Game.all
    @genres = Genre.all
    @play_methods = PlayMethod.all
  end

end
