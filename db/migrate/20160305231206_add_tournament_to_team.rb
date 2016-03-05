class AddTournamentToTeam < ActiveRecord::Migration
  def change
    add_reference :teams, :tournament, index: true
  end
end
