class Group < ApplicationRecord
  has_many :students

  def available?
    students.size < limit
  end

  def add_student(student)
    students << student
  end
end
