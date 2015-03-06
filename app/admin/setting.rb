ActiveAdmin.register Setting do
  menu priority: 6

  config.filters = false

  index do
    selectable_column
    id_column
    column :key
    column :value
    column :description
    actions
  end
end
