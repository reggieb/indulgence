class CreateThings < ActiveRecord::Migration
  
  def change
    create_table :things do |t|
      t.string :name
      t.integer :owner_id
      t.timestamps
    end
  end
end
