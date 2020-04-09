Rails.application.routes.draw do
  get "/" => "pages#index"
  get "/admin" => "pages#admin"

  get "/users" => "users#index"
  get "/users/new" => "users#new"
  post "/users" => "users#create"

  get "/auth/google_oauth2/callback" => "sessions#create"
  get "/logout" => "sessions#destroy"

  post "/door_connections" => "door_connections#create"
end
