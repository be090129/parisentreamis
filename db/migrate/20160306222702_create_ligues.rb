class CreateLigues < ActiveRecord::Migration
  def change
    create_table :ligues do |t|
      t.string :name
      t.integer :owner_id

      t.timestamps
    end
  end
end
