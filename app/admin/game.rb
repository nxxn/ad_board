ActiveAdmin.register Game do
  #menu priority: 6

  filter :name

  index do
    selectable_column
    id_column
    column :name
    column :genre
    actions
  end
end
