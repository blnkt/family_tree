class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.column :person_1_id, :integer
      t.column :person_2_id, :integer
      t.belongs_to :types_of_relationships, :integer
    end
  end
end
