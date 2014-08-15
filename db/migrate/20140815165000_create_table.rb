class CreateTable < ActiveRecord::Migration
  def change
    create_table :types_of_relationships do |t|
      t.string :type
      t.timestamps
    end
  end
end
