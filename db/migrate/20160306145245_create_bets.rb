class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.datetime :start_at
      t.integer :score1
      t.integer :score2
      t.integer :equipe1_id
      t.integer :equipe2_id
      t.integer :global_result_point
      t.integer :result_point

      t.timestamps
    end
  end
end
