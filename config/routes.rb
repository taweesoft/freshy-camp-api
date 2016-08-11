Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    mount ActionCable.server => '/live'
    get '/students' => 'students#index'
    post '/check_student' => 'students#check'
    post '/students/assign' => 'students#assign'
end
