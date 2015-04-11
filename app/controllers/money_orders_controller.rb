class MoneyOrdersController < ApplicationController

  def create
    @money_order = MoneyOrder.new(params[:money_order])
    @money_order.payment_status = "pending"

    @task = Task.find(params["money_order"]["task_id"]) if params["money_order"]["task_id"].present?

    redirect_url = params["money_order"]["task_id"].present? ? task_url(@task) : request.referrer

    if @money_order.save
      redirect_to @money_order.paypal_url(redirect_url, hook_url)
    else
      render action: "new"
    end
  end

  def add_credits
    @money_order = MoneyOrder.new
  end

end
