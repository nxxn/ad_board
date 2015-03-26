ActiveAdmin.register Review do
  menu priority: 12

  filter :user_username, as: :string, label: "Feedback receiver username"
  filter :positive

  controller do
    def scoped_collection
      Review.includes(:user, :author, :task)
    end
  end

  index do
    selectable_column
    id_column
    column ("From") { |r| (link_to r.author.username, admin_user_url(r.author)) }
    column ("To") { |r| (link_to r.user.username, admin_user_url(r.user)) }
    column :positive
    column :comment
    column ("Quest") { |r| (link_to r.task.name, admin_quest_url(r.task)) }
    actions
  end
end
