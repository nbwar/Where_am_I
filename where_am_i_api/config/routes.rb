WhereAmI::Application.routes.draw do
  namespace :api do
    post '/location.json' => 'location#determine_distance'
  end
end
