class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :post
      t.integer :point

      t.timestamps
    end
  end
end
