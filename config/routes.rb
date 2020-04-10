Rails.application.routes.draw do
  get "/" => "pages#index"
  get "/admin" => "pages#admin"

  get "/users" => "users#index"
  get "/users/new" => "users#new"
  post "/users" => "users#create"
  get "/users/:id/edit" => "users#edit"
  patch "/users/:id" => "users#update"

  get "/auth/google_oauth2/callback" => "sessions#create"
  get "/logout" => "sessions#destroy"

  post "/door_connections" => "door_connections#create"
end
