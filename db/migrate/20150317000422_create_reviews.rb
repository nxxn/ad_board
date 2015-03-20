class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer  :from
      t.integer  :user_id
      t.boolean  :positive

      t.timestamps
    end
  end
end
