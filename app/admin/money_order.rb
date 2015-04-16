ActiveAdmin.register MoneyOrder do
  #menu priority: 6

  filter :user_username, as: :string, label: "User username"
  filter :amount
  filter :payment_status, as: :select , collection: ['paid', 'pending']

  controller do
    def scoped_collection
      MoneyOrder.includes(:user)
    end
  end

  index do
    selectable_column
    id_column
    column :user
    column :amount
    column :payment_status
    column :invoice
    actions
  end
end
