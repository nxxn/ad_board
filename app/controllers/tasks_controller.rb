class TasksController < ApplicationController

  def show
    @task = Task.find(params[:id])
    @offers = Offer.where("task_id = ? AND status != ?", @task.id, "Declined")
  end

  def edit
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(params[:task])
    @task.user = current_user

    if @task.save
      redirect_to :back
    else
      render action: "new"
    end

  end

  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(params[:task])
      redirect_to :back
    else
      render action: "edit"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    redirect_to :back
  end

  def complete
    @task = Task.find(params[:id])
    if @task.user == current_user
      @task.status = "completed"
    elsif @task.worker == current_user
      @task.status = "not confirmed"
    end
    @task.save

    redirect_to :back
  end

  def confirm
    @task = Task.find(params[:id])
    if @task.user == current_user
      @task.status = "completed"
      @task.worker.balance += @task.final_price
      @task.worker.save
    end
    @task.save

    redirect_to :back
  end

  def leave_feedback
    @task = Task.find(params[:id])

    if current_user == @task.user
      #Feedback from client
      Review.create(task_id: @task.id, user_id: @task.worker.id, from: @task.user.id, positive: params[:review][:positive], comment: params[:review][:comment])
      @task.worker.update_rating
      @task.client_feedback = true
      @task.save
    else
      #Feedback from worker
      Review.create(task_id: @task.id, user_id: @task.user.id, from: @task.worker.id, positive: params[:review][:positive], comment: params[:review][:comment])
      @task.user.update_rating
      @task.worker_feedback = true
      @task.save
    end

    redirect_to :back
  end

  def pay_for_quest
    @task = Task.find(params[:id])
    @user = @task.user

    if @user.balance < @task.final_price
      @task.active = false
      @task.save

      needed_amount = @task.final_price - @user.balance

      # if needed_amount % 10 == 0   # already a factor of 10
      #   rounded_amount = needed_amount
      # else
      #   rounded_amount = needed_amount + 10 - (needed_amount % 10)  # go to nearest factor 10
      # end

      redirect_to add_credits_money_orders_path(amount: needed_amount, task: @task.id)
    else
      @task.payment_status = "paid"
      @user.balance = @user.balance - @task.final_price
      @task.save
      @user.save
      redirect_to tasks_user_path(current_user)
    end
  end

  #methods for presentation

  def accept
    @task = Task.find(params[:id])
    @task.status = "not completed"
    @task.worker = current_user
    @task.save

    redirect_to :back
  end

  def send_money
    @task = Task.find(params[:id])

    @money_order = MoneyOrder.create(amount: @task.estimated_price, user_id: @task.user_id, payment_status: "pending", invoice: SecureRandom.uuid, task_id: @task.id)

    redirect_url = request.referrer

    redirect_to @money_order.paypal_url(redirect_url, hook_url)
  end

end
