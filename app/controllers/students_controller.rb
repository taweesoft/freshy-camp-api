class StudentsController < ApplicationController

  def index
    @students = Student.all
    render :json => @students
  end

  def assign
    binding.pry
    ActionCable.server.broadcast 'students', 'Hallo, guten Morgen'
  end
end
