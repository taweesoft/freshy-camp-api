class StudentsController < ApplicationController

  def index
    @students = Student.all
    render :json => @students
  end

  def check
    @student = Student.find_by(std_id: params['username'])
    availability = false
    availability = true unless @student&.group
    render :json => {
      :username => @student&.std_id,
      :available => availability
    }
  end

  def assign
    @student = Student.find_by(std_id: params['username'])
    if @student.present?
      @student.update(group: Group.first)
      Group.first.limit = Group.first.limit - 1
      ActionCable.server.broadcast 'students', { student: @student.as_json, :color => @student.group.color }
      render :json => { student: @student.as_json, :color => @student.group.color }
    end
  end

  private

  def get_random_group
    Group.where.not(limit: 0)
    id = 1
    return Group.find(id)
  end
end
