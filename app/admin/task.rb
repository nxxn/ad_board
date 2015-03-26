ActiveAdmin.register Task, as: "Quest" do
  menu priority: 2

  filter :name
  filter :description
  filter :estimated_price, label: "Price"
  #filter :term

  controller do
    def scoped_collection
      Task.includes(:user, :game, :quest_type, :play_methods, :worker)
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :description
    column "Price", :estimated_price
    column :final_price
    column "Progress status", :status
    column "Payment status", :payment_status
    column :user
    column :client_feedback
    column :worker_feedback
    column :client
    column :worker
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
      f.input :final_price
      f.input :status, as: :select, collection: ['created', 'not completed', 'not confirmed', 'completed']
      f.input :payment_status, as: :select, collection: ['not paid', 'paid', 'pending']
      f.input :user
      f.input :worker
      f.input :worker_feedback
      f.input :client_feedback
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
      row :worker
      row :game
      row :quest_type
      row ("Play Methods"){ |q| q.play_methods.map(&:name).join(', ') }
      row :name
      row :description
      row :estimated_price
      row ("Price"){ |q| q.estimated_price}
      row ("Final price"){ |q| q.final_price}
      row ("Progress status"){ |q| q.status}
      row ("Payment status"){ |q| q.payment_status}
      row :worker_feedback
      row :client_feedback
    end
  end

end
