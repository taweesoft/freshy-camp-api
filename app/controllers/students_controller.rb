class StudentsController < ApplicationController

  def index
    @students = Student.all
    render :json => @students
  end

  def check
    @student = Student.find_by(std_id: params['username'])
    render :json => { :available => @student.present? }
  end

  def assign
    # binding.pry
    # @student = Student.find_by(std_id: params[:id])
    @student = Student.find_by(std_id: params['username'])
    @student.update(group: Group.first)
    Group.first.limit = Group.first.limit - 1
    ActionCable.server.broadcast 'students', { student: @student.as_json, :color => @student.group.color }
    render :json => { student: @student.as_json, :color => @student.group.color }
  end
end
