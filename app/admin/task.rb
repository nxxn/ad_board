ActiveAdmin.register Task, as: "Quest" do
  menu priority: 2

  filter :name
  filter :description
  filter :estimated_price, label: "Price"
  #filter :term

  controller do
    def scoped_collection
      Task.includes(:user, :game, :quest_type, :play_methods)
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :description
    column "Price", :estimated_price
    column :user
    column :game
    column :quest_type
    column("Play Methods"){ |q| q.play_methods.map(&:name).join(', ') }
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :estimated_price
      f.input :user
      f.input :game
      f.input :quest_type
      f.input :play_methods, as: :check_boxes
    end
  actions
  end

  show do
    attributes_table do
      row :id
      row :user
      row :game
      row :quest_type
      row ("Play Methods"){ |q| q.play_methods.map(&:name).join(', ') }
      row :name
      row :description
      row :estimated_price
    end
  end

end
