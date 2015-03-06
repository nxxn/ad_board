class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string  :name
      t.integer :genre_id
      
      t.timestamps
    end
  end
end
