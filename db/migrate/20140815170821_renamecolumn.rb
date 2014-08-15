class Renamecolumn < ActiveRecord::Migration
  def change
    remove_column :relationships, :types_of_relationships_id
    add_column :relationships, :type, :string
  end
end
