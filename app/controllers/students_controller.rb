class StudentsController < ApplicationController
  def assign
    binding.pry
    ActionCable.server.broadcast 'students', 'Hallo, guten Morgen'
  end
end
