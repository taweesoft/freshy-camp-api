class Student < ApplicationRecord
  after_create :test

  def test
    puts "Created"
    ActionCable.server.broadcast 'students', self.as_json
  end
end
