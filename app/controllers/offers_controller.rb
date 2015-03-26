class OffersController < ApplicationController

  def create
    @offer = Offer.new(params[:offer])
    @offer.user = current_user
    @offer.status = "Pending"

    if @offer.save
      redirect_to offers_user_path(current_user)
    else
      render action: "new"
    end
  end

  def update
    @offer = Offer.find(params[:id])
    if @offer.user_id == current_user.id
      @offer.worker_times += 1
    else
      @offer.client_times += 1
    end
    @offer.update_attributes(params[:offer])
    if @offer.user_id == current_user.id
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def client_accept
    @offer = Offer.find params[:id]
    @offer.status = "Accepted"
    @offer.save

    @task = Task.find params[:task_id]
    @task.active = false
    @task.status = "not completed"
    @task.worker_id = @offer.user.id
    @task.final_price = @offer.worker_price
    @task.save
    @user = @task.user
    @user.balance = @user.balance - @task.final_price
    @user.save

    redirect_to tasks_user_path(current_user)
  end

  def worker_accept
    @offer = Offer.find params[:id]
    @offer.status = "Accepted"
    @offer.save

    @task = Task.find params[:task_id]
    @task.active = false
    @task.status = "not completed"
    @task.worker_id = @offer.user.id
    @task.final_price = @offer.client_price
    @task.save
    @user = @task.user
    @user.balance = @user.balance - @task.final_price
    @user.save

    redirect_to tasks_user_path(current_user)
  end

  def decline
    @offer = Offer.find params[:id]
    @offer.status = "Declined"
    @offer.save

    redirect_to :back
  end

  def counter
    @offer = Offer.find params[:id]
    @offer.new_price = params[:new_price]
    @offer.save

    redirect_to :back
  end

end
