class AddNotRefreshToBets < ActiveRecord::Migration
  def change
    add_column :bets, :not_refresh, :boolean
  end
end
