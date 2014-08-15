class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.column :name, :string
    end
  end

  def change
    remove_column :people, :spouse_id, :integer
  end
end
