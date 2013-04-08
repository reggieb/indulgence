require 'active_record'
class CreateRoles < ActiveRecord::Migration
  create_table :roles do |t|
    t.string :name

    t.timestamps
  end
end
