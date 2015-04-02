class MoneyOrdersController < ApplicationController

  def create
    @money_order = MoneyOrder.new(params[:money_order])
    #@money_order.user = current_user
    @money_order.payment_status = "pending"

    if @money_order.save
      redirect_to @money_order.paypal_url(request.referrer, hook_url)
    else
      render action: "new"
    end
  end

end
