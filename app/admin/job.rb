ActiveAdmin.register Job do
  menu priority: 4

  filter :status, as: :select, collection: ['Started', 'Finished']
  filter :price

  index do
    selectable_column
    id_column
    column "Worker", :user
    column :task
    column :price
    column :status
    column :term
    actions
  end
end
