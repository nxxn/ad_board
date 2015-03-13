ActiveAdmin.register Game do
  #menu priority: 6

  filter :name

  controller do
     def scoped_collection
       Game.includes(:genre)
     end
   end

  index do
    selectable_column
    id_column
    column :name
    column :genre
    actions
  end
end
