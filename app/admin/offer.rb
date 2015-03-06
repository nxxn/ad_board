ActiveAdmin.register Offer do
  menu priority: 3

  filter :status, as: :select , collection: ['Pending', 'Approved', 'Declined']

  index do
    selectable_column
    id_column
    column :task
    column :user
    column :status
    column :client_price
    column "Quest owner price", :client_price
    column :comment
    actions
  end
end
