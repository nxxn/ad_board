class HomeController < ApplicationController

  def index
    if params[:genre].present?
      @genre = Genre.where(name: params[:genre]).first
      @tasks = []
      @genre.games.each{|g| @tasks = @tasks + g.tasks.where(active: true, status: "created").includes(:user, :game, :quest_type, :play_methods).order('created_at DESC') }
    elsif params[:game].present?
      @game = Game.where(name: params[:game]).first
      @tasks = @game.tasks.where(active: true, status: "created").includes(:user, :game, :quest_type, :play_methods).order('created_at DESC')
    elsif params[:play_method].present?
      @method = PlayMethod.where(name: params[:play_method]).first
      @tasks = @method.tasks.where(active: true, status: "created").includes(:user, :game, :quest_type, :play_methods).order('created_at DESC')
    elsif params[:price].present?
      @tasks = Task.where(active: true, status: "created").includes(:user, :game, :quest_type, :play_methods).order('estimated_price DESC')
    else
      @tasks = Task.where(active: true, status: "created").includes(:user, :game, :quest_type, :play_methods).order('created_at DESC')
    end

    @offer = Offer.new

    @games = Game.all
    @genres = Genre.all
    @play_methods = PlayMethod.all
  end

end
