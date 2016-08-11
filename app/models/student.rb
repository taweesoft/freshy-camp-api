class Student < ApplicationRecord
  belongs_to :group, optional: true

  after_create :test

  def test
    puts "Created"
    ActionCable.server.broadcast 'students', self.as_json
  end
end
