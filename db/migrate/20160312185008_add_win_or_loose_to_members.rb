class AddWinOrLooseToMembers < ActiveRecord::Migration
  def change
    add_column :members, :pwin, :integer
    add_column :members, :ploose, :integer
  end
end
