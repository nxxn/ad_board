class MoneyOrder < ActiveRecord::Base
  attr_accessible :amount, :user_id, :payment_status, :invoice, :task_id

  belongs_to :user
  has_one :payment_notification

  def paypal_url(return_path, notify_path)
    values = {
      business: "PayPal@mmonster.eu",
      cmd: "_xclick",
      upload: 1,
      return: return_path,
      rm: 0,
      invoice: invoice,
      amount: Setting.get_value("price_for_credit").to_f,
      item_name: "Payment for quest",
      quantity: (amount.to_i),
      notify_url: notify_path
    }
    "https://www.paypal.com/cgi-bin/webscr?" + values.to_query
  end

end
