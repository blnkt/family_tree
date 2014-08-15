class AddColumnsToRelationships < ActiveRecord::Migration
  def change
    remove_column :relationships, :person_1_id
    remove_column :relationships, :person_2_id
    remove_column :relationships, :relationship_type
    add_column :relationships, :parent_id, :integer
    add_column :relationships, :child_id, :integer
    add_column :relationships, :person_id, :integer

  end
end
