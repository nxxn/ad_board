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

end
