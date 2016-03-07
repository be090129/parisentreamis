class AddTournamentRefToLigues < ActiveRecord::Migration
  def change
    add_reference :ligues, :tournament, index: true
  end
end
