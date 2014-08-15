class DropIntCol < ActiveRecord::Migration
  def change
    remove_column :relationships, :integer_id, :integer
  end
end
