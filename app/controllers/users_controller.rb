class UsersController < ApplicationController

  def show
    @user = User.find params[:id]
  end

  def tasks
    @user = User.find params[:id]
    @tasks = Task.where(user_id: @user.id).includes(:user)
    @task = Task.new
  end

  def offers
    @user = User.find params[:id]
    @offers = @user.offers
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

end
