class StudentsChannel < ActionCable::Channel::Base
  def subscribed
    stream_from 'students'
  end
end
