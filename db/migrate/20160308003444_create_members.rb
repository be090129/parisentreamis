class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.references :user, index: true
      t.references :ligue, index: true
      t.string :status
      t.integer :score
      t.integer :scoreday

      t.timestamps
    end
  end
end
