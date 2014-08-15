class CreateTables < ActiveRecord::Migration
  def change
    create_table :types_of_relationships do |t|
      t.string :type
      t.timestamps
    end
  end

  def change
    remove_column :people, :spouse_id, :integer
  end
end
