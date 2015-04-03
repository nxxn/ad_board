class ChangeUserBalanceToFloat < ActiveRecord::Migration
  def up
    change_column :users, :balance, :float
  end

  def down
    # Either change the column back, or mark it as irreversible with:
    change_column :users, :balance, :decimal, :precision => 15, :scale => 2, null: false
  end
end
