class AddTournamentIdToPronostics < ActiveRecord::Migration
  def change
    add_column :pronostics, :tournament_id, :integer
  end
end
