class AddStudentsCount < ActiveRecord::Migration[5.0]
  def up
    add_column :groups, :students_count, :integer, default: 0
    Group.reset_column_information
    Group.all.each do |p|
      Group.update_counters p.id, :students_count => p.students.length
    end
  end

  def down
    remove_column :groups, :students_count
  end
end
