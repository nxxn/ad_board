class UsersController < ApplicationController
  protect_from_forgery except: [:hook, :show]

  def show
    @user = User.find params[:id]
  end

  def tasks
    @user = User.find params[:id]
    @tasks = Task.where(user_id: @user.id).includes(:user, :game, :quest_type, :play_methods)
    @task = Task.new
  end

  def offers
    @user = User.find params[:id]
    @offers = Offer.where(user_id: @user.id).includes(:user, :task => [:user])
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
    params.permit! # Permit all Paypal input params
    ap params
    status = params[:payment_status]
    if status == "Completed"
      @registration = Registration.find params[:invoice]
      @registration.update_attributes notification_params: params, status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end

end
