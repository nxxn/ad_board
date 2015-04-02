class PaymentNotification < ActiveRecord::Base
  attr_accessible :params, :status, :transaction_id, :money_order_id

  belongs_to :money_order
end
