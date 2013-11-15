WhereAmI::Application.routes.draw do
  namespace :api do
    get '/location.json' => 'location#determine_distance'
  end

  get '/blah' => 'location#blah'
end
