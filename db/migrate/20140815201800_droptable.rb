class Droptable < ActiveRecord::Migration
  def change
    drop_table :types_of_relationships
  end
end
