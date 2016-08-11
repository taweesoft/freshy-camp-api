class AddGroupRefToStudents < ActiveRecord::Migration[5.0]
  def change
    add_column :students, :group_id, :integer
    add_index :students, :group_id
  end
end
