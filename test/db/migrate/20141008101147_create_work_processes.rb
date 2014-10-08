class CreateWorkProcesses < ActiveRecord::Migration
  def change
    create_table :work_processes do |t|
      t.string :name
      t.string :stage
      t.timestamps
    end
  end
end
