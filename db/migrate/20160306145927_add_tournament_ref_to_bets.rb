class AddTournamentRefToBets < ActiveRecord::Migration
  def change
    add_reference :bets, :tournament, index: true
  end
end
