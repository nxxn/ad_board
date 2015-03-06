ActiveAdmin.register Genre do
  #menu priority: 6

  filter :name

  index do
    selectable_column
    id_column
    column :name
    actions
  end
end
