class UsersController < ApplicationController
  protect_from_forgery except: [:hook, :show]

  def show
    @user = User.find params[:id]
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
      @tasks = Task.where("worker_id = ? OR user_id = ?", @user.id, @user.id).includes(:game, :quest_type, :play_methods, :user, :worker)
    end
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
    # ap params
    # if params[:payment_status] == "Completed"
    #   @money_order = MoneyOrder.where(invoice: params[:invoice]).first
    #   @money_order.payment_status = "paid"
    #   @user = @money_order.user
    #   @user.balance += params[:quantity].to_i
    #   if !@money_order.task_id.nil?
    #     @task = Task.find(@money_order.task_id)
    #     @task.active = true
    #     @task.payment_status = "paid"
    #     @user.balance -= @task.final_price
    #     @task.save
    #   end
    #   @money_order.save
    #   @user.save
    #   PaymentNotification.create!(
    #     params: params.to_s,
    #     money_order_id: @money_order.id,
    #     status: params[:payment_status],
    #     transaction_id: params[:txn_id]
    #   )
    # end
    # ap @money_order
    # ap @user

    #changes for presentation

    if params[:payment_status] == "Completed"
      @money_order = MoneyOrder.where(invoice: params[:invoice]).first
      @money_order.payment_status = "paid"

      if !@money_order.task_id.nil?
        @task = Task.find(@money_order.task_id)
        @task.active = true
        @task.payment_status = "paid"
        @task.save
      end
      @money_order.save

      PaymentNotification.create!(
        params: params.to_s,
        money_order_id: @money_order.id,
        status: params[:payment_status],
        transaction_id: params[:txn_id]
      )
    end

    render nothing: true
  end

end
