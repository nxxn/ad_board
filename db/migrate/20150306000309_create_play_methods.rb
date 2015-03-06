class CreatePlayMethods < ActiveRecord::Migration
  def change
    create_table :play_methods do |t|
      t.string  :name
      
      t.timestamps
    end
  end
end
