class UsersController < ApplicationController
  protect_from_forgery except: [:hook, :show]

  def show
    @user = User.find params[:id]
    @task = Task.new
    @offer = Offer.new
    @completed_quests = Task.where(worker_id: @user.id, status: "completed")
    @user_quests = Task.where(user_id: @user.id, active: true).includes(:game, :quest_type, :play_methods)
  end

  def tasks
    @user = User.find params[:id]
    if params[:status] == "in_progress_by_me"
      @tasks = Task.where("worker_id = ? AND (status = ? OR status =?)", @user.id, "not completed", "not confirmed").includes(:game, :quest_type, :play_methods, :user, :worker)
    elsif params[:status] == "in_progress_for_me"
      @tasks = Task.where(user_id: @user.id, status: "not completed").includes(:game, :quest_type, :play_methods)
    elsif params[:status] == "completed_by_me"
      @tasks = Task.where(worker_id: @user.id, status: "completed").includes(:game, :quest_type, :play_methods, :user, :worker)
    elsif params[:status] == "completed_for_me"
      @tasks = Task.where("user_id = ? AND (status = ? OR status =?)", @user.id, "completed", "not confirmed").includes(:game, :quest_type, :play_methods, :user, :worker)
    else
      @tasks = Task.where(user_id: @user.id, status: "created").includes(:game, :quest_type, :play_methods)
    end
    @task = Task.new
    @review = Review.new
  end

  def offers
    @user = User.find params[:id]
    @offers = Offer.where(user_id: @user.id).includes(:user, :task => [:user, :game, :quest_type, :play_methods])
  end

  def jobs
    @user = User.find params[:id]
    @jobs = @user.jobs
  end

  def create_offer
    @task = Task.find params[:task_id]
    @status = params[:new_price].present ? "new_price" : "pending"
    @new_price = params[:new_price] if params[:new_price].present?

    @offer = Offer.create(user_id: current_user.id, task_id: @task.id, status: "")
  end

  def manual_approve
    @user = User.find(params[:id])
    @user.approved = true
    @user.save

    redirect_to :back
  end

  def hook
    ap params
    status = params[:payment_status]
    if status == "Completed"
      ap "true"
    end
    render nothing: true
  end

end
