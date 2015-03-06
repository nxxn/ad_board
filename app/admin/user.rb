ActiveAdmin.register User do
  menu priority: 5

  filter :email
  filter :is_admin
  filter :username
  filter :first_name
  filter :last_name
  filter :street
  filter :town
  filter :country
  filter :post_index
  filter :phone

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :username
      f.input :first_name
      f.input :last_name
      f.input :street
      f.input :post_index
      f.input :town
      f.input :country, as: :string
      f.input :phone
      f.input :is_admin
    end
    actions
  end

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :first_name
    column :last_name
    column :street
    column :post_index
    column :town
    column :country
    column :phone
    column :is_admin
    actions
  end

end
