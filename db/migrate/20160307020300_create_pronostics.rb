class CreatePronostics < ActiveRecord::Migration
  def change
    create_table :pronostics do |t|
      t.integer :user_id
      t.integer :bet_id
      t.integer :ligue_id
      t.integer :score1
      t.integer :score2

      t.timestamps
    end
  end
end
