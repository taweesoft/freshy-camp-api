class StudentsController < ApplicationController

  def index
    @students = Student.where(group_id: nil)
    binding.pry
    render :json => @students
  end

  def check
    @student = Student.find_by(std_id: params['username'])
    render :json => {
      :student => @student.as_json,
      :available => @student&.group.blank?
    }
  end

  def assign
    @student = Student.find_by(std_id: params['username'])
    if @student.present?
      group = get_random_group
      group.add_student(@student)
      ActionCable.server.broadcast 'students', { student: @student.as_json, :color => @student.group.color }
      render :json => { student: @student.as_json, :color => @student.group.color }
    end
  end

  private

  def get_random_group
    groups = Group.joins(:students).
     group(:id).
     order("count(*) asc").
     limit(3)
    ids = groups.pluck(:id)
    group = Group.find(ids.sample)
    while (!group.available?)
      group = Group.find(ids.sample)
    end
    return group
  end
end
